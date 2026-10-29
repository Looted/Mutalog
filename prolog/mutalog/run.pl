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
Mutants run on a pool of workers, one child process each, longest
expected mutants first. Crashes are retried on a fresh worker before
they are reported.

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
    config_value(retries, Config, Retries),
    config_value(worker_reuse, Config, Reuse),
    (   memberchk(progress(Progress), Overrides)
    ->  true
    ;   Progress = true
    ),
    findall(I-M, nth1(I, All, M), Numbered),
    foldl(plan_mutant(Index, Times, TimeoutMs, Factor), Numbered,
          []-[], Uncovered-Jobs0),
    schedule(Jobs0, Jobs),
    pool_size(Config, Jobs, Size),
    report_uncovered(Progress, Total, Uncovered, Done),
    run_pool(Size, settings(Ctx, Retries, Reuse), Jobs,
             progress(Progress, Total, Done), Ran),
    append(Uncovered, Ran, All1),
    keysort(All1, Sorted),
    pairs_values(Sorted, Results).

%   A planned mutant is either resolved at once (no covering test) or
%   becomes job(I, M, Tests, LimitMs) for the pool.

plan_mutant(Index, Times, TimeoutMs, Factor, I-M, U0-J0, U-J) :-
    covering_tests(Index, M, Tests),
    (   Tests == []
    ->  U = [I-r(M, no_coverage, none, 0, [])|U0], J = J0
    ;   foldl(add_test_time(Times), Tests, 0, Sum),
        LimitMs is round(Factor * Sum + TimeoutMs),
        U = U0, J = [job(I, M, Tests, LimitMs)|J0]
    ).

add_test_time(Times, T, S0, S) :-
    get_assoc(T, Times, Ms),
    S is S0 + Ms.

%   Longest expected mutants first, so that a slow mutant does not
%   start last and leave the other workers idle. The time limit is
%   proportional to the covering tests' time, so it serves as the
%   estimate. Ties keep source order.

schedule(Jobs0, Jobs) :-
    map_list_to_pairs(job_cost, Jobs0, Keyed0),
    reverse(Keyed0, Keyed1),
    sort(1, @>=, Keyed1, Keyed),
    pairs_values(Keyed, Jobs).

job_cost(job(I, _, _, LimitMs), LimitMs-NegI) :-
    NegI is -I.

%!  pool_size(+Config, +Jobs, -Size) is det.
%
%   `concurrency(N)` with N > 0 asks for N workers; 0 means one fewer
%   than the CPU count. Never more workers than jobs, never fewer
%   than one.

pool_size(Config, Jobs, Size) :-
    config_value(concurrency, Config, C),
    (   C > 0
    ->  Want = C
    ;   current_prolog_flag(cpu_count, CPUs),
        Want is max(1, CPUs - 1)
    ),
    length(Jobs, NJ),
    Size is max(1, min(Want, NJ)).

report_uncovered(Progress, Total, Uncovered, Done) :-
    reverse(Uncovered, InOrder),
    foldl(report_one(Progress, Total), InOrder, 0, Done).

report_one(Progress, Total, _-R, N0, N) :-
    N is N0 + 1,
    report_progress(Progress, N, Total, R).

report_progress(true, N, Total, r(M, Status, _, _, _)) :-
    !,
    get_dict(id, M, Id),
    format(user_error, "[~d/~d] ~w ~w~n", [N, Total, Status, Id]).
report_progress(_, _, _, _).

%   ---------------------------------------------------------------
%   Worker pool
%
%   Each pool thread owns one worker process and takes jobs from a
%   shared queue until it receives `done`. Results come back on a
%   second queue as done(I, Result); a thread that cannot go on sends
%   failed(Error). The worker a thread currently holds is kept in its
%   thread-local global variable `mutalog_worker`, so it is stopped
%   however the thread ends.

run_pool(_, _, [], _, []) :-
    !.
run_pool(Size, Settings, Jobs, Progress, Results) :-
    message_queue_create(JQ),
    message_queue_create(RQ),
    forall(member(J, Jobs), thread_send_message(JQ, J)),
    forall(between(1, Size, _), thread_send_message(JQ, done)),
    findall(T,
            ( between(1, Size, _),
              thread_create(pool_thread(Settings, JQ, RQ), T, [])
            ),
            Threads),
    length(Jobs, NJ),
    call_cleanup(collect(NJ, RQ, Progress, Results),
                 Catcher,
                 stop_pool(Catcher, Threads, JQ, RQ)).

collect(0, _, _, []) :-
    !.
collect(N, RQ, progress(P, Total, Done0), [I-R|Rs]) :-
    thread_get_message(RQ, Msg),
    (   Msg = failed(E)
    ->  throw(E)
    ;   Msg = done(I, R)
    ),
    Done is Done0 + 1,
    report_progress(P, Done, Total, R),
    N1 is N - 1,
    collect(N1, RQ, progress(P, Total, Done), Rs).

stop_pool(Catcher, Threads, JQ, RQ) :-
    (   Catcher == exit
    ->  true
    ;   forall(member(T, Threads),
               catch(thread_signal(T, throw(mutalog_stop)), _, true))
    ),
    forall(member(T, Threads), catch(thread_join(T, _), _, true)),
    message_queue_destroy(JQ),
    message_queue_destroy(RQ).

pool_thread(Settings, JQ, RQ) :-
    Settings = settings(Ctx, _, _),
    nb_setval(mutalog_worker, none),
    catch(( start_worker(Ctx, W),
            nb_setval(mutalog_worker, W),
            pool_loop(Settings, JQ, RQ, W, 0)
          ),
          E,
          catch(thread_send_message(RQ, failed(E)), _, true)),
    stop_current_worker.

stop_current_worker :-
    nb_getval(mutalog_worker, W),
    nb_setval(mutalog_worker, none),
    (   W == none
    ->  true
    ;   worker_stop(W)
    ).

pool_loop(Settings, JQ, RQ, W0, Used0) :-
    thread_get_message(JQ, Msg),
    (   Msg == done
    ->  true
    ;   Msg = job(I, M, Tests, LimitMs),
        Settings = settings(Ctx, Retries, Reuse),
        recycle(Ctx, Reuse, W0, Used0, W1, Used1),
        attempt(Ctx, M, Tests, LimitMs, Retries, W1, W, Status, KilledBy, Ms),
        thread_send_message(RQ, done(I, r(M, Status, KilledBy, Ms, Tests))),
        Used is Used1 + 1,
        pool_loop(Settings, JQ, RQ, W, Used)
    ).

%   With `worker_reuse(N)`, N > 0, a worker is replaced after N
%   mutants, which bounds how much state a project's tests can leak
%   from one mutant into the next.

recycle(Ctx, Reuse, W0, Used, W, 0) :-
    Reuse > 0,
    Used >= Reuse,
    !,
    replace_worker(Ctx, W0, W).
recycle(_, _, W, Used, W, Used).

replace_worker(Ctx, W0, W) :-
    nb_setval(mutalog_worker, none),
    worker_stop(W0),
    new_worker(Ctx, W).

new_worker(Ctx, W) :-
    start_worker(Ctx, W),
    nb_setval(mutalog_worker, W).

%   A crash may come from state an earlier mutant left behind rather
%   than from the mutant itself, so it is tried again, up to `retries`
%   more times, on a fresh worker. Timeouts are not retried: a timeout
%   already counts as detected, and retrying a mutant that really
%   loops would double the slowest part of a run.

attempt(Ctx, M, Tests, LimitMs, Left, W0, W, Status, KilledBy, Ms) :-
    try_mutant(Ctx, M, Tests, LimitMs, W0, W1, Status0, KilledBy0, Ms0),
    (   retryable(Status0),
        Left > 0
    ->  Left1 is Left - 1,
        (   W1 == W0
        ->  replace_worker(Ctx, W1, W2)
        ;   W2 = W1
        ),
        attempt(Ctx, M, Tests, LimitMs, Left1, W2, W, Status, KilledBy, Ms)
    ;   W = W1, Status = Status0, KilledBy = KilledBy0, Ms = Ms0
    ).

retryable(runtime_error).

try_mutant(Ctx, M, Tests, LimitMs, W0, W, Status, KilledBy, Ms) :-
    HardS is LimitMs / 1000 + 10,
    get_dict(id, M, Id),
    get_dict(file, M, Rel),
    get_dict(start, M, Start),
    get_dict(end, M, End),
    get_dict(replacement, M, Repl),
    Cmd = mutant(Id, Rel, Start, End, Repl, Tests, LimitMs),
    worker_call(W0, Cmd, HardS, Reply),
    (   Reply = result(_, Status, KilledBy, Ms)
    ->  W = W0
    ;   nb_setval(mutalog_worker, none),
        (   Reply == timeout
        ->  Status = timeout, KilledBy = none, Ms = LimitMs
        ;   Status = runtime_error, KilledBy = none, Ms = 0
        ),
        new_worker(Ctx, W)
    ).

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
