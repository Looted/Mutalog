:- module(mutalog_run,
          [ collect_mutants/3,       % +Config, +Root, -Files
            mutalog_dry_run/3,       % +Root, +Overrides, -DryRun
            mutalog_run/3,           % +Root, +Overrides, -Run
            mutant_counts/2,         % +Results, -Counts
            mutation_score/3         % +Counts, -Score, -CoveredScore
          ]).

/** <module> Running mutants

The pipeline after mutant generation: start a worker, load the project
and its tests, run the suite once under coverage (the dry run), then
apply each mutant and run only the tests that entered its clause.

Statuses and scores:

  | Status          | Meaning                                         |
  | --------------- | ----------------------------------------------- |
  | `killed`        | a covering test failed                          |
  | `survived`      | every covering test passed                      |
  | `timeout`       | the tests ran past the time limit               |
  | `no_coverage`   | no test entered the mutated clause              |
  | `compile_error` | the mutated file did not load                   |
  | `runtime_error` | the worker crashed                              |
  | `ignored`       | listed in `ignore_mutants`                      |

The mutation score is (killed + timeout) / (killed + timeout + survived
+ no_coverage). The score on covered code leaves out `no_coverage`.
*/

:- use_module(library(lists)).
:- use_module(library(apply)).
:- use_module(library(pairs)).
:- use_module(library(assoc)).
:- use_module(config).
:- use_module(discover).
:- use_module(reader).
:- use_module(operators).
:- use_module(generate).
:- use_module(client).

%!  collect_mutants(+Config, -Root, -Files) is det.
%
%   Files is a list of file(Rel, Mutants, Source) for every file the
%   config's `mutate` globs select, with ignored mutants removed.

collect_mutants(Config, ProjectRoot, Files) :-
    config_value(root, Config, ProjectRoot),
    config_value(mutate, Config, Patterns),
    config_value(ignore, Config, Ignore),
    config_value(operators, Config, Ops),
    config_value(ignore_mutants, Config, IgnoreIds0),
    maplist(to_atom, IgnoreIds0, IgnoreIds),
    check_operators(Ops),
    discover_files(ProjectRoot, Patterns, Ignore, Rels),
    maplist(file_mutants(ProjectRoot, Ops, IgnoreIds), Rels, Files).

to_atom(X, A) :- atom_string(A, X).

check_operators(Ops) :-
    operator_names(Known),
    forall(member(Op, Ops),
           (   memberchk(Op, Known)
           ->  true
           ;   domain_error(mutalog_operator, Op)
           )).

file_mutants(Root, Ops, IgnoreIds, Rel, file(Rel, Mutants, Source)) :-
    directory_file_path(Root, Rel, Path),
    read_source(Path, Source),
    source_mutants(Source, Rel, Ops, Mutants0),
    exclude(ignored_mutant(IgnoreIds), Mutants0, Mutants).

ignored_mutant(IgnoreIds, M) :-
    memberchk(M.id, IgnoreIds).

%   ---------------------------------------------------------------
%   Worker setup

project_tests(Config, Root, Tests) :-
    config_value(tests, Config, Patterns),
    discover_files(Root, Patterns, [], Tests),
    (   Tests == []
    ->  throw(error(mutalog(no_test_files(Patterns)), _))
    ;   true
    ).

worker_options(Config, Overrides, [stack_limit(Limit), verbose(Verbose)]) :-
    config_value(stack_limit, Config, Limit),
    (   memberchk(verbose(Verbose), Overrides)
    ->  true
    ;   Verbose = false
    ).

start_worker(Ctx, W) :-
    Ctx = ctx(Root, WOpts, Loads, Tests, MutateRels),
    worker_start(Root, WOpts, W),
    worker_call(W, init(Root, Loads, Tests, MutateRels), 600, Reply),
    (   Reply = ready(_)
    ->  true
    ;   worker_stop(W),
        throw(error(mutalog(worker_init(Reply)), _))
    ).

%!  mutalog_dry_run(+Root, +Overrides, -DryRun) is det.
%
%   DryRun is dry(Config, Files, Results): the dry-run result per test
%   and the generated mutants.

mutalog_dry_run(Root, Overrides, dry(Config, Files, Results, Ctx)) :-
    load_config(Root, Overrides, Config),
    collect_mutants(Config, ProjectRoot, Files),
    project_tests(Config, ProjectRoot, Tests),
    config_value(load, Config, Loads),
    worker_options(Config, Overrides, WOpts),
    findall(Rel, member(file(Rel, _, _), Files), Rels),
    Ctx = ctx(ProjectRoot, WOpts, Loads, Tests, Rels),
    start_worker(Ctx, W),
    worker_call(W, dry_run, 3600, Reply),
    worker_stop(W),
    (   Reply = dry(Results)
    ->  true
    ;   throw(error(mutalog(dry_run(Reply)), _))
    ).

%!  mutalog_run(+Root, +Overrides, -Run) is det.
%
%   Run is run(Config, Results, Tests) where Results holds one
%   r(Mutant, Status, KilledBy, Ms, CoveredBy) per mutant.

mutalog_run(Root, Overrides, run(Config, Results, DryResults)) :-
    mutalog_dry_run(Root, Overrides, dry(Config, Files, DryResults, Ctx)),
    include([t(_, failed, _, _)]>>true, DryResults, Failed),
    (   Failed \== []
    ->  findall(T, member(t(T, failed, _, _), Failed), FailedTests),
        throw(error(mutalog(initial_test_run_failed(FailedTests)), _))
    ;   true
    ),
    coverage_index(DryResults, Index, Times),
    findall(M, ( member(file(_, Ms, _), Files), member(M, Ms) ), All0),
    select_only(Overrides, All0, All),
    length(All, Total),
    config_value(timeout_ms, Config, TimeoutMs),
    config_value(timeout_factor, Config, Factor),
    (   memberchk(progress(Progress), Overrides)
    ->  true
    ;   Progress = true
    ),
    Limits = limits(TimeoutMs, Factor, Progress),
    start_worker(Ctx, W0),
    foldl(run_one(Ctx, Index, Times, Limits, Total), All, Results,
          state(W0, 0), state(W, _)),
    worker_call(W, restore, 600, _),
    worker_stop(W).

select_only(Overrides, All, Selected) :-
    (   memberchk(only(Ids0), Overrides)
    ->  maplist(to_atom, Ids0, Ids),
        include(selected_mutant(Ids), All, Selected)
    ;   Selected = All
    ).

selected_mutant(Ids, M) :-
    memberchk(M.id, Ids).

%   Index maps Rel-Line to the tests that entered that clause, in dry
%   run order; Times maps each test to its dry-run time in ms.

coverage_index(DryResults, Index, Times) :-
    findall(Key-Test,
            ( member(t(Test, _, _, Covered), DryResults),
              member(Key, Covered)
            ),
            Pairs),
    keysort(Pairs, Sorted),
    group_pairs_by_key(Sorted, Grouped),
    list_to_assoc(Grouped, Index),
    findall(Test-Ms, member(t(Test, _, Ms, _), DryResults), TimePairs),
    list_to_assoc(TimePairs, Times).

covering_tests(Index, M, Tests) :-
    get_dict(file, M, Rel),
    get_dict(clause_line, M, Line),
    (   get_assoc(Rel-Line, Index, Tests)
    ->  true
    ;   Tests = []
    ).

run_one(Ctx, Index, Times, Limits, Total, M,
        r(M, Status, KilledBy, Ms, Tests), state(W0, N0), state(W, N)) :-
    N is N0 + 1,
    covering_tests(Index, M, Tests),
    (   Tests == []
    ->  Status = no_coverage, KilledBy = none, Ms = 0, W = W0
    ;   Limits = limits(TimeoutMs, Factor, _),
        foldl([T, S0, S]>>(get_assoc(T, Times, TMs), S is S0 + TMs), Tests, 0, Sum),
        LimitMs is round(Factor * Sum + TimeoutMs),
        HardS is LimitMs / 1000 + 30,
        Cmd = mutant(M.id, M.file, M.start, M.end, M.replacement, Tests, LimitMs),
        worker_call(W0, Cmd, HardS, Reply),
        (   Reply = result(_, Status, KilledBy, Ms)
        ->  W = W0
        ;   Reply == timeout
        ->  Status = timeout, KilledBy = none, Ms = LimitMs,
            start_worker(Ctx, W)
        ;   Status = runtime_error, KilledBy = none, Ms = 0,
            start_worker(Ctx, W)
        )
    ),
    (   arg(3, Limits, true)
    ->  format(user_error, "[~d/~d] ~w ~w~n", [N, Total, Status, M.id])
    ;   true
    ).

%!  mutant_counts(+Results, -Counts) is det.
%
%   Counts is a list Status-Count over all statuses.

mutant_counts(Results, Counts) :-
    Statuses = [killed, survived, timeout, no_coverage,
                compile_error, runtime_error, ignored],
    findall(S-C,
            ( member(S, Statuses),
              aggregate_all(count, member(r(_, S, _, _, _), Results), C)
            ),
            Counts).

%!  mutation_score(+Counts, -Score, -CoveredScore) is det.
%
%   Percentages, or `none` when there is nothing to score.

mutation_score(Counts, Score, CoveredScore) :-
    memberchk(killed-K, Counts),
    memberchk(timeout-T, Counts),
    memberchk(survived-S, Counts),
    memberchk(no_coverage-N, Counts),
    Detected is K + T,
    percentage(Detected, Detected + S + N, Score),
    percentage(Detected, Detected + S, CoveredScore).

percentage(_, Total0, none) :-
    Total0 =:= 0,
    !.
percentage(Part, Total, P) :-
    P is 100 * Part / Total.
