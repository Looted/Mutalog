:- module(mutalog_worker,
          [ worker_main/0
          ]).

/** <module> Mutant worker

A worker is a child `swipl` process. It loads the project and its plunit
tests once, then reads commands from standard input and answers each on
standard output, one Prolog term per line. Everything the project and
its tests print goes to standard error, so it cannot corrupt the
protocol.

Commands and replies:

  - init(Root, LoadFiles, TestFiles, MutateFiles)
    -> ready(Tests) | load_error(Messages)
  - dry_run
    -> dry(Results), one t(Unit:Test, passed|failed, Ms, Covered) per
       test, Covered being the File-Line clause starts it entered in the
       mutate files
  - mutant(Id, File, Start, End, Replacement, Tests, LimitMs)
    -> result(Id, Status, KilledBy, Ms)
  - test_info -> tests(Infos), one test(Unit:Test, File, Line) per
    test, File relative to the project root or `none`
  - restore -> restored
  - halt

A mutant is applied by reloading its file from the source text with the
replacement spliced in, which is exactly what the compiler would see had
the change been made on disk. The original is reloaded before a mutant
of another file is applied, and on `restore`.
*/

:- use_module(library(plunit)).
:- use_module(library(lists)).
:- use_module(library(apply)).
:- use_module(library(readutil)).
:- use_module(library(time)).

:- dynamic
    protocol_out/1,
    mutate_file/2,             % Rel, LoadedPath
    original_text/2,           % LoadedPath, Text
    mutated/1.                 % LoadedPath currently holding a mutant

:- multifile user:message_hook/3.
:- discontiguous handle/2.

%   Count error messages so that a load or reload that reports errors
%   is recognised even when it does not throw.

user:message_hook(_, error, _) :-
    flag(mutalog_errors, N, N + 1),
    fail.

%!  worker_main is det.

worker_main :-
    set_prolog_flag(encoding, utf8),
    stream_property(Out, alias(user_output)),
    set_stream(Out, encoding(utf8)),
    set_stream(user_input, encoding(utf8)),
    assertz(protocol_out(Out)),
    set_stream(user_error, alias(user_output)),
    set_output(user_error),
    loop.

loop :-
    catch(read_term(user_input, Cmd, []), E, (Cmd = error(E))),
    (   Cmd == end_of_file
    ->  true
    ;   Cmd == halt
    ->  true
    ;   catch(handle(Cmd, Reply), E2, Reply = worker_error(E2)),
        reply(Reply),
        loop
    ).

reply(Term) :-
    protocol_out(Out),
    write_term(Out, Term, [quoted(true), fullstop(true), nl(true)]),
    flush_output(Out).

%   ---------------------------------------------------------------
%   init

handle(init(Root, Loads, Tests, Mutate), Reply) :-
    working_directory(_, Root),
    set_test_options([silent(true)]),
    flag(mutalog_errors, _, 0),
    maplist(load_project_file, Loads),
    maplist(load_test_file, Tests),
    flag(mutalog_errors, Errors, 0),
    (   Errors > 0
    ->  Reply = load_error(Errors)
    ;   maplist(register_mutate_file, Mutate),
        all_tests(TestIds),
        Reply = ready(TestIds)
    ).

load_project_file(File) :-
    load_files(File, [if(not_loaded)]).

load_test_file(File) :-
    load_files(File, [if(not_loaded)]).

register_mutate_file(Rel) :-
    absolute_file_name(Rel, Abs, [access(read)]),
    (   source_file(Loaded),
        same_file(Loaded, Abs)
    ->  assertz(mutate_file(Rel, Loaded))
    ;   true                     % not loaded by the tests: no coverage
    ).

all_tests(Tests) :-
    findall(Unit:Test,
            plunit:current_test(Unit, Test, _, _, _),
            Tests).

%   ---------------------------------------------------------------
%   dry run

handle(dry_run, dry(Results)) :-
    all_tests(Tests),
    maplist(dry_test, Tests, Results).

dry_test(Test, t(Test, Status, Ms, Covered)) :-
    cov_reset,
    get_time(T0),
    setup_call_cleanup(
        cov_start(Level),
        run_test(Test, Status),
        cov_stop(Level)),
    get_time(T1),
    Ms is round((T1 - T0) * 1000),
    covered_clauses(Covered),
    cov_reset.

%   A time limit that fires inside the test must reach the caller, so
%   it is the one exception not turned into a failure here.

run_test(Test, Status) :-
    (   catch(run_tests(Test), E, test_exception(E))
    ->  Status = passed
    ;   Status = failed
    ).

test_exception(E) :-
    (   E == time_limit_exceeded
    ->  throw(E)
    ;   fail
    ).

covered_clauses(Covered) :-
    findall(Rel-Line,
            ( '$cov_data'(clause(Ref), Enter, _),
              Enter > 0,
              clause_property(Ref, file(File)),
              mutate_file(Rel, File),
              clause_property(Ref, line_count(Line))
            ),
            Covered0),
    sort(Covered0, Covered).

%   The coverage primitives changed arity in SWI-Prolog 9.1.

cov_start(Level) :-
    (   current_predicate(system:'$cov_start'/1)
    ->  call('$cov_start', Level)
    ;   call('$cov_start'),
        Level = 0
    ).

cov_stop(Level) :-
    (   current_predicate(system:'$cov_stop'/1)
    ->  call('$cov_stop', Level)
    ;   call('$cov_stop')
    ).

cov_reset :-
    call('$cov_reset').

%   ---------------------------------------------------------------
%   mutants

handle(mutant(Id, Rel, Start, End, Replacement, Tests, LimitMs),
       result(Id, Status, KilledBy, Ms)) :-
    get_time(T0),
    (   mutate_file(Rel, File)
    ->  apply_mutant(File, Start, End, Replacement, Applied),
        (   Applied == ok
        ->  run_mutant_tests(Tests, T0, LimitMs, Status, KilledBy)
        ;   Status = compile_error,
            KilledBy = none
        )
    ;   Status = no_coverage,
        KilledBy = none
    ),
    get_time(T1),
    Ms is round((T1 - T0) * 1000).

handle(test_info, tests(Infos)) :-
    working_directory(Dir, Dir),
    findall(test(Unit:Test, File, Line),
            ( plunit:current_test(Unit, Test, Line, _, _),
              unit_rel_file(Dir, Unit, File)
            ),
            Infos).

unit_rel_file(Dir, Unit, Rel) :-
    (   catch(plunit:unit_file(Unit, File), _, fail),
        atom(File)
    ->  directory_file_path(Dir, x, Ref),
        relative_file_name(File, Ref, Rel)
    ;   Rel = none
    ).

handle(restore, restored) :-
    restore_all.

apply_mutant(File, Start, End, Replacement, Result) :-
    forall(( mutated(Other), Other \== File ), restore_file(Other)),
    original(File, Text),
    sub_string(Text, 0, Start, _, Before),
    sub_string(Text, End, _, 0, After),
    atomics_to_string([Before, Replacement, After], Mutated),
    retractall(mutated(File)),
    assertz(mutated(File)),
    reload(File, Mutated, Result).

restore_all :-
    forall(mutated(File), restore_file(File)).

restore_file(File) :-
    original(File, Text),
    reload(File, Text, _),
    retractall(mutated(File)).

original(File, Text) :-
    (   original_text(File, Text)
    ->  true
    ;   read_file_to_string(File, Text, [encoding(utf8)]),
        assertz(original_text(File, Text))
    ).

reload(File, Text, Result) :-
    flag(mutalog_errors, _, 0),
    setup_call_cleanup(
        open_string(Text, In),
        catch(load_files(File, [stream(In), silent(true)]), E, true),
        close(In)),
    flag(mutalog_errors, Errors, 0),
    (   var(E), Errors =:= 0
    ->  Result = ok
    ;   Result = error
    ).

%   Run the covering tests one by one, stopping at the first failure.
%   Each test gets what is left of the mutant's time budget.

run_mutant_tests([], _, _, survived, none).
run_mutant_tests([Test|Tests], T0, LimitMs, Status, KilledBy) :-
    get_time(Now),
    LeftS is (LimitMs / 1000) - (Now - T0),
    (   LeftS =< 0
    ->  Status = timeout, KilledBy = none
    ;   catch(call_with_time_limit(LeftS, run_test(Test, S0)),
              time_limit_exceeded, S0 = timeout),
        get_time(After),
        ElapsedS is After - T0,
        (   S0 == passed
        ->  run_mutant_tests(Tests, T0, LimitMs, Status, KilledBy)
        ;   ( S0 == timeout ; ElapsedS >= LimitMs / 1000 )
        ->  Status = timeout, KilledBy = Test
        ;   Status = killed, KilledBy = Test
        )
    ).
