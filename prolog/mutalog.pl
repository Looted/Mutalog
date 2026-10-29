:- module(mutalog,
          [ main/0,
            mutalog_list/3          % +Root, +Overrides, -Result
          ]).

/** <module> Mutalog: mutation testing for SWI-Prolog

Mutalog changes the code under test in small ways (a flipped comparison,
a removed cut, a dropped clause) and checks that the plunit suite
notices. It follows Stryker's model and vocabulary.

Command line:

```
mutalog run     [OPTIONS] [--only ID,ID] [--verbose]
mutalog dry-run [OPTIONS]
mutalog list    [OPTIONS] [--format text|json] [--check]

OPTIONS: [--config FILE] [--mutate GLOB]... [--tests GLOB]...
         [--operators a,b] [--timeout-ms N]
```
*/

:- use_module(library(lists)).
:- use_module(library(apply)).
:- use_module(library(http/json)).
:- use_module(mutalog/config).
:- use_module(mutalog/discover).
:- use_module(mutalog/reader).
:- use_module(mutalog/operators).
:- use_module(mutalog/generate).
:- use_module(mutalog/run).

:- initialization(check_version).

check_version :-
    current_prolog_flag(version, V),
    (   V >= 90000
    ->  true
    ;   print_message(warning, format("Mutalog needs SWI-Prolog 9.0 or later", []))
    ).

%!  main is det.
%
%   Command-line entry point. Halts with the command's exit code.

main :-
    current_prolog_flag(argv, Argv),
    catch(run_cli(Argv, Code), E, (print_message(error, E), Code = 2)),
    halt(Code).

run_cli([list|Args], Code) :-
    !,
    parse_options(Args, Opts),
    working_directory(Cwd, Cwd),
    cli_overrides(Opts, Overrides),
    mutalog_list(Cwd, Overrides, Result),
    (   memberchk(format(json), Opts)
    ->  print_json(Result)
    ;   print_text(Result)
    ),
    (   memberchk(check, Opts)
    ->  check_result(Result, Code)
    ;   Code = 0
    ).
run_cli([run|Args], Code) :-
    !,
    parse_options(Args, Opts),
    working_directory(Cwd, Cwd),
    cli_overrides(Opts, Overrides),
    mutalog_run(Cwd, Overrides, Run),
    print_run(Run, Code).
run_cli(['dry-run'|Args], Code) :-
    !,
    parse_options(Args, Opts),
    working_directory(Cwd, Cwd),
    cli_overrides(Opts, Overrides),
    mutalog_dry_run(Cwd, Overrides, Dry),
    print_dry_run(Dry, Code).
run_cli([Cmd|_], 2) :-
    Cmd \== help,
    !,
    format(user_error, "mutalog: unknown command ~w~n", [Cmd]),
    usage.
run_cli(_, 0) :-
    usage.

usage :-
    forall(member(L, [ "Usage: mutalog run|dry-run|list [OPTIONS]",
                       "  --config FILE       config file (default mutalog.config.pl)",
                       "  --mutate GLOB       files to mutate, repeatable",
                       "  --tests GLOB        test files, repeatable",
                       "  --operators a,b     operators to use",
                       "  --timeout-ms N      extra time per mutant",
                       "  run:  --only ID,ID  run only these mutants",
                       "        --verbose     show the project's own output",
                       "  list: --format text|json, --check"
                     ]),
           format(user_error, "~w~n", [L])).

parse_options([], []).
parse_options(['--config', F|T], [config(F)|Os]) :- !, parse_options(T, Os).
parse_options(['--mutate', G|T], [mutate(G)|Os]) :- !, parse_options(T, Os).
parse_options(['--operators', L|T], [operators(Ops)|Os]) :-
    !,
    atomic_list_concat(Ops, ',', L),
    parse_options(T, Os).
parse_options(['--format', F|T], [format(F)|Os]) :- !, parse_options(T, Os).
parse_options(['--check'|T], [check|Os]) :- !, parse_options(T, Os).
parse_options(['--tests', G|T], [tests(G)|Os]) :- !, parse_options(T, Os).
parse_options(['--only', L|T], [only(Ids)|Os]) :-
    !,
    atomic_list_concat(Ids, ',', L),
    parse_options(T, Os).
parse_options(['--timeout-ms', N|T], [timeout_ms(V)|Os]) :-
    !,
    atom_number(N, V),
    parse_options(T, Os).
parse_options(['--verbose'|T], [verbose(true)|Os]) :- !, parse_options(T, Os).
parse_options([X|_], _) :-
    domain_error(mutalog_option, X).

cli_overrides(Opts, Overrides) :-
    findall(G, member(mutate(G), Opts), Globs),
    (   Globs == []
    ->  O0 = []
    ;   O0 = [mutate(Globs)]
    ),
    findall(G, member(tests(G), Opts), TestGlobs),
    (   TestGlobs == []
    ->  O00 = O0
    ;   O00 = [tests(TestGlobs)|O0]
    ),
    findall(X, ( member(X, Opts),
                 ( X = timeout_ms(_) ; X = only(_) ; X = verbose(_) ) ),
            Passed),
    append(Passed, O00, O1),
    (   memberchk(operators(Ops), Opts)
    ->  O2 = [operators(Ops)|O1]
    ;   O2 = O1
    ),
    (   memberchk(config(F), Opts)
    ->  Overrides = [config(F)|O2]
    ;   Overrides = O2
    ).

%!  mutalog_list(+Root, +Overrides, -Result) is det.
%
%   Result is `result(Files)` with one `file(Rel, Mutants, Checks)` per
%   source file, where Checks pairs each mutant id with the outcome of
%   verify_mutant/3.

mutalog_list(Root, Overrides, result(Files)) :-
    load_config(Root, Overrides, Config),
    collect_mutants(Config, _, Files0),
    maplist(check_file, Files0, Files).

check_file(file(Rel, Mutants, Source), file(Rel, Mutants, Checks)) :-
    findall(Id-R,
            ( member(M, Mutants),
              get_dict(id, M, Id),
              verify_mutant(Source, M, R)
            ),
            Checks).

check_result(result(Files), Code) :-
    findall(Id-E, ( member(file(_, _, Checks), Files),
                    member(Id-E, Checks),
                    E \== ok ),
            Bad),
    (   Bad == []
    ->  Code = 0
    ;   forall(member(Id-E, Bad),
               format(user_error, "mutalog: ~w does not re-read: ~q~n", [Id, E])),
        Code = 1
    ).

%   ---------------------------------------------------------------
%   Output: run

print_run(run(Config, Results, Tests), Code) :-
    length(Tests, NTests),
    format("~nRan ~d tests in the dry run.~n", [NTests]),
    include(status_is(survived), Results, Survived),
    (   Survived == []
    ->  true
    ;   length(Survived, NS),
        format("~nSurvived (~d):~n", [NS]),
        forall(member(r(M, _, _, _, Covering), Survived),
               ( print_mutant(M),
                 length(Covering, NC),
                 format("      covered by ~d test(s)~n", [NC]) ))
    ),
    include(status_is(timeout), Results, Timeouts),
    (   Timeouts == []
    ->  true
    ;   length(Timeouts, NT),
        format("~nTimed out (~d):~n", [NT]),
        forall(member(r(M, _, _, _, _), Timeouts), print_mutant(M))
    ),
    run_table(Results),
    mutant_counts(Results, Counts),
    mutation_score(Counts, Score, Covered),
    percent_text(Score, ST),
    percent_text(Covered, CT),
    format("~nMutation score: ~w (covered code: ~w)~n", [ST, CT]),
    (   memberchk(thresholds(H, L, B), Config)
    ->  break_code(thresholds(H, L, B), Score, Code)
    ;   Code = 0
    ).

status_is(S, r(_, S, _, _, _)).

percent_text(none, 'n/a') :- !.
percent_text(P, T) :- format(atom(T), '~1f%', [P]).

break_code(thresholds(_, _, break(B)), Score, Code) :-
    (   number(Score), number(B), Score < B
    ->  format(user_error, "mutalog: score ~1f% is below break threshold ~w%~n", [Score, B]),
        Code = 1
    ;   Code = 0
    ).

run_table(Results) :-
    findall(F, ( member(r(M, _, _, _, _), Results), get_dict(file, M, F) ), Fs0),
    sort(Fs0, Fs),
    format("~n~w~t~40|~t~w~48|~t~w~56|~t~w~64|~t~w~72|~t~w~80|~t~w~88|~n",
           ['File', 'Score', 'Killed', 'Surv.', 'Timeout', 'No cov.', 'Errors']),
    forall(member(F, Fs),
           ( include(result_file(F), Results, Rs),
             table_row(F, Rs) )),
    table_row('All files', Results).

result_file(F, r(M, _, _, _, _)) :-
    get_dict(file, M, F).

table_row(Name, Rs) :-
    mutant_counts(Rs, Counts),
    mutation_score(Counts, Score, _),
    memberchk(killed-K, Counts),
    memberchk(survived-S, Counts),
    memberchk(timeout-T, Counts),
    memberchk(no_coverage-N, Counts),
    memberchk(compile_error-CE, Counts),
    memberchk(runtime_error-RE, Counts),
    E is CE + RE,
    percent_text(Score, SA),
    format("~w~t~40|~t~w~48|~t~d~56|~t~d~64|~t~d~72|~t~d~80|~t~d~88|~n",
           [Name, SA, K, S, T, N, E]).

%   ---------------------------------------------------------------
%   Output: dry run

print_dry_run(dry(_, Files, Results, _), Code) :-
    format("~w~t~60|~t~w~70|~t~w~80|~n", ['Test', 'Time (ms)', 'Clauses']),
    forall(member(t(Test, Status, Ms, Covered), Results),
           ( length(Covered, NC),
             format("~q~t~60|~t~d~70|~t~d~80|  ~w~n", [Test, Ms, NC, Status]) )),
    findall(T, member(t(T, failed, _, _), Results), Failed),
    findall(M, ( member(file(_, Ms0, _), Files), member(M, Ms0) ), All),
    length(All, NM),
    length(Results, NT),
    format("~n~d tests, ~d mutants~n", [NT, NM]),
    (   Failed == []
    ->  Code = 0
    ;   format(user_error, "mutalog: failing tests: ~q~n", [Failed]),
        Code = 1
    ).

%   ---------------------------------------------------------------
%   Output: list

print_text(result(Files)) :-
    forall(member(file(Rel, Ms, _), Files),
           ( length(Ms, N),
             format("~w: ~d mutants~n", [Rel, N]),
             forall(member(M, Ms), print_mutant(M)) )),
    summary(Files).

print_mutant(M) :-
    one_line(M.original, O),
    one_line(M.replacement, R),
    format("  ~w~n      ~w  ->  ~w~n", [M.id, O, R]).

one_line(S0, S) :-
    split_string(S0, "\n", " \t", Parts),
    exclude(==(""), Parts, Parts1),
    atomic_list_concat(Parts1, ' ', A),
    (   A == ''
    ->  S = '(removed)'
    ;   S = A
    ).

summary(Files) :-
    findall(Op, ( member(file(_, Ms, _), Files),
                  member(M, Ms),
                  get_dict(operator, M, Op) ), Ops),
    length(Ops, Total),
    length(Files, NFiles),
    msort(Ops, Sorted),
    clumped_pairs(Sorted, Counts),
    format("~nTotal: ~d mutants in ~d files~n", [Total, NFiles]),
    forall(member(Op-N, Counts), format("  ~w~t~16|~d~n", [Op, N])).

clumped_pairs(Sorted, Counts) :-
    clumped(Sorted, Counts).

print_json(result(Files)) :-
    maplist(file_json, Files, FilesJson),
    json_write_dict(current_output, _{files: FilesJson}, [width(0)]),
    nl.

file_json(file(Rel, Ms, Checks), _{path: Rel, mutants: MsJson}) :-
    maplist(mutant_json(Checks), Ms, MsJson).

mutant_json(Checks, M, J) :-
    memberchk(M.id-Check, Checks),
    (   Check == ok
    ->  CheckS = "ok"
    ;   term_string(Check, CheckS)
    ),
    J = _{ id: M.id, operator: M.operator,
           location: _{ start: _{line: M.line, column: M.column},
                        end: _{line: M.end_line, column: M.end_column} },
           range: [M.start, M.end],
           original: M.original, replacement: M.replacement,
           check: CheckS }.
