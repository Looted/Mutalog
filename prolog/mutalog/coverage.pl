:- module(mutalog_coverage,
          [ dry_test/3,             % +MutateFiles, +Test, -Result
            run_test/2              % +Test, -Status
          ]).

/** <module> Dry run under coverage

The worker, a child `swipl` process, runs every test once under
SWI-Prolog's coverage instrumentation before any mutant is applied. Each
run records the test's time and the clauses of the mutated files it
entered, which decide the tests a mutant runs and its time limit.
*/

:- use_module(library(plunit)).
:- use_module(library(lists)).

%!  dry_test(+MutateFiles, +Test, -Result) is det.
%
%   Run Test under coverage. Result is t(Test, passed|failed, Ms,
%   Covered), Covered being the sorted Rel-Line clause starts it entered
%   in MutateFiles, a list of Rel-LoadedPath pairs.

dry_test(MutateFiles, Test, t(Test, Status, Ms, Covered)) :-
    cov_reset,
    get_time(T0),
    setup_call_cleanup(
        cov_start(Level),
        run_test(Test, Status),
        cov_stop(Level)),
    get_time(T1),
    Ms is round((T1 - T0) * 1000),
    covered_clauses(MutateFiles, Covered),
    cov_reset.

%!  run_test(+Test, -Status) is det.
%
%   Run one plunit test, Unit:Name. A time limit that fires inside the
%   test must reach the caller, so it is the one exception not turned
%   into a failure here.

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

covered_clauses(MutateFiles, Covered) :-
    findall(Rel-Line,
            ( '$cov_data'(clause(Ref), Enter, _),
              Enter > 0,
              clause_property(Ref, file(File)),
              memberchk(Rel-File, MutateFiles),
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
