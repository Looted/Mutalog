% Clause coverage of prolog/ by the test suite: swipl test/coverage.pl
%
% Runs every test, like test/run.pl, with coverage recorded in this
% process and in every swipl it starts (see coverage/swi-prolog/init.pl),
% then lists each clause of prolog/ that no process entered. Exits 1
% when a test fails or a clause is left uncovered.
%
% Pool threads are not recorded on SWI-Prolog 9.0, so the pool's code
% is covered by tests that call it from the main thread. Clauses that
% run where recording is off are listed in unrecorded/3, each with the
% test that shows it runs.

:- initialization(coverage_main, main).

:- use_module(library(plunit)).
:- use_module(library(lists)).
:- use_module(library(apply)).
:- use_module(library(pairs)).
:- set_prolog_flag(encoding, utf8).

:- dynamic load_errors/1.
load_errors(0).

:- multifile user:message_hook/3.
user:message_hook(_, error, _) :-
    retract(load_errors(N)),
    N1 is N + 1,
    assertz(load_errors(N1)),
    fail.

coverage_main :-
    prolog_load_context_dir(TestDir),
    file_directory_name(TestDir, Repo),
    directory_file_path(Repo, 'prolog/', Src),
    directory_file_path(TestDir, coverage, ConfigHome),
    tmp_file(mutalog_coverage, Out),
    make_directory(Out),
    setenv('XDG_CONFIG_HOME', ConfigHome),
    setenv('MUTALOG_COVERAGE_OUT', Out),
    setenv('MUTALOG_COVERAGE_SRC', Src),
    directory_file_path(ConfigHome, 'swi-prolog/init.pl', Init),
    load_files(user:Init, []),
    maplist(directory_file_path(Repo),
            [ 'prolog/mutalog.pl', 'prolog/mutalog/worker.pl',
              'test/test_mutalog.plt', 'test/test_e2e.plt' ],
            Files),
    load_files(Files, []),
    load_errors(Errors),
    (   Errors =:= 0,
        run_tests
    ->  Passed = true
    ;   Passed = false
    ),
    '$mutalog_cov_dump',
    report(Src, Out, Uncovered),
    (   Passed == true,
        Uncovered == []
    ->  halt(0)
    ;   halt(1)
    ).

:- dynamic test_dir/1.
:- prolog_load_context(directory, D), assertz(test_dir(D)).
prolog_load_context_dir(D) :- test_dir(D).

%   Every clause loaded from Src, as File-Line-Module:Name/Arity, less
%   the load records of module `system`, and the File-Line pairs some
%   process entered.

report(Src, Out, Uncovered) :-
    findall(File-Line-PI, source_clause(Src, File, Line, PI), All1),
    sort(All1, All0),
    directory_files(Out, Names),
    findall(F-L,
            ( member(Name, Names),
              file_name_extension(_, pl, Name),
              directory_file_path(Out, Name, Path),
              read_hits(Path, Hits),
              member(hit(F, L), Hits)
            ),
            Hit0),
    sort(Hit0, Hit),
    partition(unrecorded(Src), All0, Unrecorded, All),
    exclude(hit_clause(Hit), All, Uncovered),
    length(All, NAll),
    length(Uncovered, NUn),
    format("~n~w~t~60|~t~w~70|~t~w~78|~n", ['File', 'Clauses', 'Covered']),
    findall(F, member(F-_-_, All), Fs0),
    sort(Fs0, Fs),
    forall(member(F, Fs), file_row(Src, F, All, Uncovered)),
    Pct is 100 * (NAll - NUn) / NAll,
    format("~w~t~60|~t~d~70|~t~1f%~78|~n", ['All files', NAll, Pct]),
    forall(member(F-L-PI, Unrecorded),
           ( atom_concat(Src, Rel, F),
             unrecorded(Rel, PI, Why),
             format("~nNot recordable: ~w:~d  ~q~n  ~w~n", [Rel, L, PI, Why]) )),
    (   Uncovered == []
    ->  true
    ;   format("~nNot covered:~n"),
        forall(member(F-L-PI, Uncovered),
               ( atom_concat(Src, Rel, F),
                 format("  ~w:~d  ~q~n", [Rel, L, PI]) ))
    ).

file_row(Src, F, All, Uncovered) :-
    include([F0-_-_]>>(F0 == F), All, In),
    include([F0-_-_]>>(F0 == F), Uncovered, Un),
    length(In, N),
    length(Un, U),
    Pct is 100 * (N - U) / N,
    atom_concat(Src, Rel, F),
    format("~w~t~60|~t~d~70|~t~1f%~78|~n", [Rel, N, Pct]).

%   Clauses coverage cannot see, with the test that shows they run.
%   print_message/2 calls its hooks with recording off.

unrecorded('mutalog/worker.pl', user:message_hook/3,
           'A message hook; e2e:mostly_compile_errors_fails_the_break checks the first error it keeps.').

unrecorded(Src, F-_-PI) :-
    atom_concat(Src, Rel, F),
    unrecorded(Rel, PI, _).

hit_clause(Hit, F-L-_) :-
    memberchk(F-L, Hit).

read_hits(Path, Hits) :-
    setup_call_cleanup(open(Path, read, In),
                       read_terms(In, Hits),
                       close(In)).

read_terms(In, Terms) :-
    read_term(In, T, []),
    (   T == end_of_file
    ->  Terms = []
    ;   Terms = [T|Rest],
        read_terms(In, Rest)
    ).

source_clause(Src, File, Line, M:Name/Arity) :-
    current_module(M),
    M \== system,
    current_predicate(M:Name/Arity),
    functor(H, Name, Arity),
    \+ predicate_property(M:H, imported_from(_)),
    \+ pldoc_name(Name),
    nth_clause(M:H, _, Ref),
    clause_property(Ref, file(File)),
    sub_atom(File, 0, _, _, Src),
    clause_property(Ref, line_count(Line)).

pldoc_name('$pldoc').
pldoc_name('$mode').
pldoc_name('$pred_option').
pldoc_name('$exported_op').
