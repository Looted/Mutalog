:- use_module(library(plunit)).
:- use_module(library(lists)).
:- use_module(library(apply)).
:- use_module('../prolog/mutalog').
:- use_module('../prolog/mutalog/config').
:- use_module('../prolog/mutalog/discover').
:- use_module('../prolog/mutalog/reader').
:- use_module('../prolog/mutalog/generate').
:- use_module('../prolog/mutalog/operators').
:- use_module('../prolog/mutalog/run').
:- use_module('../prolog/mutalog/report').
:- use_module('../prolog/mutalog/client').
:- use_module('../prolog/mutalog/coverage', []).
:- use_module(capture).
:- use_module(library(http/json)).
:- use_module(library(readutil)).
:- use_module(library(process)).

fixtures_dir(Dir) :-
    source_file(fixtures_dir(_), File),
    file_directory_name(File, TestDir),
    directory_file_path(TestDir, fixtures, Dir).

%   test/project has strong tests for most of calc.pl, a weak test for
%   max2/3, none for unused/1, and a mutant that loops forever.

project_dir(Dir) :-
    fixtures_dir(Fixtures),
    file_directory_name(Fixtures, TestDir),
    directory_file_path(TestDir, project, Dir).

%   Mutants of one fixture file with the given operators.

fixture_mutants(File, Ops, Mutants) :-
    fixtures_dir(Dir),
    mutalog_list(Dir, [mutate([File]), operators(Ops)],
                 result([file(_, Mutants, Checks)])),
    forall(member(Id-C, Checks),
           assertion(C-Id == ok-Id)).

op_count(File, Op, N) :-
    fixture_mutants(File, [Op], Ms),
    length(Ms, N).

replacements(File, Op, Rs) :-
    fixture_mutants(File, [Op], Ms),
    maplist([M, R]>>get_dict(replacement, M, R), Ms, Rs).

write_file(File, Text) :-
    setup_call_cleanup(open(File, write, Out), write(Out, Text), close(Out)).
append_file(File, Text) :-
    setup_call_cleanup(open(File, append, Out), write(Out, Text), close(Out)).

%   The text print_message/2 shows for Term, without printing it: the
%   message goes to a string that stands in for user_error.

message_text(Term, Text) :-
    stream_property(Err, alias(user_error)),
    with_output_to(string(Text),
                   ( current_output(Out),
                     setup_call_cleanup(set_stream(Out, alias(user_error)),
                                        print_message(error, Term),
                                        set_stream(Err, alias(user_error))) )).

:- begin_tests(operators).

test(arith)       :- op_count('sample.pl', arith, 1).
test(compare)     :- op_count('sample.pl', compare, 4).
test(unify)       :- op_count('sample.pl', unify, 2).
test(negate)      :- op_count('sample.pl', negate, 2).
test(cut)         :- op_count('sample.pl', cut, 1).
test(goal_true)   :- op_count('sample.pl', goal_true, 8).
test(goal_fail)   :- op_count('sample.pl', goal_fail, 10).
test(clause_drop) :- op_count('sample.pl', clause_drop, 4).
test(literal)     :- op_count('sample.pl', literal, 6).

test(all_operators) :-
    default_operators(Ops),
    fixture_mutants('sample.pl', Ops, Ms),
    length(Ms, 38).

test(compare_text, Rs == ["X =< 10", "X >= 10", "X > 10", "X < 10"]) :-
    replacements('sample.pl', compare, Rs).

test(negate_text, Rs == ["\\+ memberchk(Key-Value, Pairs)", "X == off"]) :-
    replacements('sample.pl', negate, Rs).

test(literal_text, Rs == ["11", "-10", "11", "-10", "[_]", "1"]) :-
    replacements('sample.pl', literal, Rs).

test(cut_insert, Rs == ["(member(X, Y), !)"]) :-
    replacements('cut_insert.pl', cut_insert, Rs).

test(cut_removes_only, Rs == []) :-
    replacements('cut_insert.pl', cut, Rs).

test(clause_drop_text) :-
    fixture_mutants('cut_insert.pl', [clause_drop], [M1, M2]),
    assertion(M1.original == "pick(X, Y) :- member(X, Y), X > 0."),
    assertion(M1.replacement == ""),
    assertion(M1.mutated_clause == none),
    assertion(M2.original == "pick(_, none).").

test(no_fused_tokens, Rs == ["2", " -1", "X + 1", "2", " -1"]) :-
    fixture_mutants('spacing.pl', [literal, arith], Ms),
    maplist([M, R]>>get_dict(replacement, M, R), Ms, Rs).

test(custom_operators) :-
    fixture_mutants('custom_ops.pl', [goal_fail, unify], Ms),
    length(Ms, 5).

test(skips_directives_and_dcg, Ms == []) :-
    default_operators(Ops),
    exclude(==(goal_fail), Ops, Ops1),
    fixture_mutants('skipped.pl', Ops1, Ms).

test(unknown_operator, error(domain_error(mutalog_operator, nope))) :-
    fixtures_dir(Dir),
    mutalog_list(Dir, [mutate(['sample.pl']), operators([nope])], _).

:- end_tests(operators).

:- begin_tests(ids).

test(stable_and_unique) :-
    default_operators(Ops),
    fixture_mutants('sample.pl', Ops, Ms1),
    fixture_mutants('sample.pl', Ops, Ms2),
    maplist([M, Id]>>get_dict(id, M, Id), Ms1, Ids1),
    maplist([M, Id]>>get_dict(id, M, Id), Ms2, Ids2),
    assertion(Ids1 == Ids2),
    sort(Ids1, Sorted),
    length(Ids1, N), length(Sorted, N).

test(id_format, Id == 'sample.pl:6:23:compare:1') :-
    fixture_mutants('sample.pl', [compare], [M|_]),
    Id = M.id.

test(location) :-
    fixture_mutants('sample.pl', [arith], [M]),
    assertion(M.line == 13),
    assertion(M.original == "S0 + H").

test(ignore_mutants) :-
    fixtures_dir(Dir),
    mutalog_list(Dir, [mutate(['sample.pl']), operators([compare]),
                       ignore_mutants(["sample.pl:6:23:compare:1"])],
                 result([file(_, Ms, _)])),
    length(Ms, 3).

:- end_tests(ids).

:- begin_tests(discover).

test(glob_star)     :- glob_match('src/*.pl', 'src/a.pl').
test(glob_star_dir, fail) :- glob_match('src/*.pl', 'src/x/a.pl').
test(glob_deep)     :- glob_match('src/**/*.pl', 'src/x/y/a.pl').
test(glob_deep_zero):- glob_match('src/**/*.pl', 'src/a.pl').
test(glob_braces)   :- glob_match('src/{a,b}.pl', 'src/b.pl').

test(discover, Files == ['all_ops.pl', 'custom_ops.pl', 'cut_insert.pl', 'meta_goals.pl',
                         'sample.pl', 'spacing.pl']) :-
    fixtures_dir(Dir),
    discover_files(Dir, ['**/*.pl'], ['skipped.pl'], Files).

:- end_tests(discover).

:- begin_tests(config).

test(defaults) :-
    fixtures_dir(Dir),
    load_config(Dir, [], C),
    config_value(timeout_ms, C, 5000),
    config_value(operators, C, Ops),
    default_operators(Ops).

test(file_and_overrides) :-
    tmp_file(mutalog_cfg, Dir),
    make_directory(Dir),
    directory_file_path(Dir, 'mutalog.config.pl', File),
    setup_call_cleanup(open(File, write, Out),
                       format(Out, "mutate([\"a.pl\"]).~ntimeout_ms(100).~n", []),
                       close(Out)),
    load_config(Dir, [timeout_ms(200)], C),
    assertion(config_value(mutate, C, ["a.pl"])),
    assertion(config_value(timeout_ms, C, 200)).

test(unknown_key, error(domain_error(_, bogus(1)))) :-
    tmp_file(mutalog_cfg, Dir),
    make_directory(Dir),
    directory_file_path(Dir, 'mutalog.config.pl', File),
    setup_call_cleanup(open(File, write, Out),
                       format(Out, "bogus(1).~n", []),
                       close(Out)),
    load_config(Dir, [], _).

%   The project root is the config file's directory, moved by a root/1
%   term (relative to that directory) or a root/1 override (relative
%   to the directory Mutalog runs in).

test(config_root) :-
    tmp_file(mutalog_cfg, Dir),
    directory_file_path(Dir, conf, ConfDir),
    directory_file_path(Dir, proj, ProjDir),
    make_directory(Dir),
    make_directory(ConfDir),
    make_directory(ProjDir),
    directory_file_path(ConfDir, 'a.config.pl', A),
    directory_file_path(ConfDir, 'b.config.pl', B),
    write_file(A, "timeout_ms(1).\n"),
    write_file(B, "root(\"../proj\").\n"),
    load_config(Dir, [config('conf/a.config.pl')], CA),
    config_value(root, CA, RA),
    assertion(RA == ConfDir),
    load_config(Dir, [config('conf/b.config.pl')], CB),
    config_value(root, CB, RB),
    assertion(RB == ProjDir),
    load_config(Dir, [config('conf/b.config.pl'), root(conf)], CC),
    config_value(root, CC, RC),
    assertion(RC == ConfDir),
    catch(load_config(Dir, [root(nope)], _), E, true),
    assertion(E = error(existence_error(_, nope), _)).

:- end_tests(config).

:- begin_tests(self).

%   Mutalog's own sources go through the same pipeline: every mutant of
%   every module must re-read as the clause it claims to be.

test(self_mutants_reread) :-
    fixtures_dir(Fixtures),
    file_directory_name(Fixtures, TestDir),
    file_directory_name(TestDir, Root),
    mutalog_list(Root, [mutate(['prolog/**/*.pl'])], result(Files)),
    assertion(Files \== []),
    forall(( member(file(_, _, Checks), Files), member(Id-C, Checks) ),
           assertion(C-Id == ok-Id)).

:- end_tests(self).

:- begin_tests(worker).

%   Reloading a file over a previous mutant must not leave a clause of
%   that mutant answering calls. SWI-Prolog 10 did so for a clause that
%   ran between the two reloads unless the file is unloaded first.
%   Whether it shows varies from process to process, so the scenario
%   runs in several fresh processes.

test(reload_drops_stale_clauses, Counts == [0, 0, 0, 0, 0, 0, 0, 0]) :-
    fixtures_dir(Fixtures),
    file_directory_name(Fixtures, TestDir),
    directory_file_path(TestDir, 'reload_scenario.pl', Script),
    current_prolog_flag(executable, Exe),
    length(Counts, 8),
    maplist(run_reload_scenario(Exe, Script), Counts).

run_reload_scenario(Exe, Script, Count) :-
    process_create(Exe, ['-q', '-g', main, '-t', halt, Script],
                   [stdout(pipe(Out)), process(Pid)]),
    read_term(Out, Count, []),
    close(Out),
    process_wait(Pid, exit(0)).

:- end_tests(worker).

:- begin_tests(run).

project_run(Results) :-
    project_dir(Dir),
    mutalog_run(Dir, [progress(false)], run(_, Results, Tests, _)),
    length(Tests, 7).

status_of(Results, Id, Status) :-
    member(r(M, Status, _, _, _), Results),
    get_dict(id, M, Id),
    !.

test(counts) :-
    project_run(Results),
    mutant_counts(Results, Counts),
    assertion(memberchk(killed-35, Counts)),
    assertion(memberchk(survived-12, Counts)),
    assertion(memberchk(timeout-2, Counts)),
    assertion(memberchk(no_coverage-6, Counts)),
    assertion(memberchk(compile_error-0, Counts)),
    assertion(memberchk(runtime_error-0, Counts)).

test(statuses) :-
    project_run(Results),
    assertion(status_of(Results, 'src/calc.pl:14:30:arith:1', timeout)),
    assertion(status_of(Results, 'src/calc.pl:19:14:unify:1', no_coverage)),
    assertion(status_of(Results, 'src/calc.pl:16:18:compare:1', survived)),
    assertion(status_of(Results, 'src/calc.pl:10:35:arith:1', killed)).

test(killed_by) :-
    project_run(Results),
    member(r(M, killed, By, _, Covering), Results),
    get_dict(id, M, 'src/calc.pl:10:35:arith:1'),
    !,
    assertion(By == calc:sum),
    assertion(memberchk(calc:sum, Covering)).

test(only) :-
    project_dir(Dir),
    mutalog_run(Dir, [progress(false), only(["src/calc.pl:14:30:arith:1"])], run(_, Results, _, _)),
    assertion(Results = [r(_, timeout, _, _, _)]).

test(dry_run_coverage) :-
    project_dir(Dir),
    mutalog_dry_run(Dir, [], dry(_, _, Results, _, _)),
    assertion(memberchk(t(calc:max_first, passed, _, ['src/calc.pl'-16]), Results)),
    assertion(\+ ( member(t(_, _, _, Cov), Results),
                   memberchk('src/calc.pl'-19, Cov) )).

test(initial_test_run_failed,
     error(mutalog(initial_test_run_failed([broken:fails])), _)) :-
    tmp_project(Dir, "p(1).\n", ":- use_module('../src/p').\n:- begin_tests(broken).\ntest(fails) :- p(2).\n:- end_tests(broken).\n"),
    mutalog_run(Dir, [progress(false)], _).

test(no_test_files, error(mutalog(no_test_files(['nope/*.plt'], Dir)), _)) :-
    project_dir(Dir),
    mutalog_dry_run(Dir, [tests(['nope/*.plt'])], _).

test(no_source_files, error(mutalog(no_source_files(['nope/*.pl'], Dir)), _)) :-
    project_dir(Dir),
    mutalog_dry_run(Dir, [mutate(['nope/*.pl'])], _).

test(unknown_only, error(mutalog(unknown_mutants(['src/calc.pl:1:1:arith:1'])), _)) :-
    project_dir(Dir),
    mutalog_dry_run(Dir, [only(["src/calc.pl:14:30:arith:1", "src/calc.pl:1:1:arith:1"])], _).

%   Stale ignore_mutants ids are reported only for files and operators
%   in the run.

test(stale_ignore_warning, Stale == ['src/calc.pl:1:1:arith:1']) :-
    project_dir(Dir),
    setup_call_cleanup(
        asserta((user:message_hook(mutalog(stale_ignore_mutants(Ids)), warning, _) :-
                    nb_setval(mutalog_stale, Ids)), Ref),
        ( nb_setval(mutalog_stale, []),
          mutalog_list(Dir, [operators([arith]),
                             ignore_mutants([ "src/calc.pl:1:1:arith:1",
                                              "src/calc.pl:1:1:cut:1",
                                              "other.pl:1:1:arith:1" ])], _),
          nb_getval(mutalog_stale, Stale) ),
        erase(Ref)).

%   `% mutalog-disable-next-line` drops the mutants that start on the
%   next line: all of them, or only the operators it names.

test(disable_next_line) :-
    tmp_project(Dir,
                "p(X) :-\n    % mutalog-disable-next-line cut_insert: det\n    X > 0,\n    true.\np(0).\n% mutalog-disable-next-line\nq(1).\n",
                ""),
    mutalog_list(Dir, [mutate(['src/p.pl'])], result([file(_, Ms, _)])),
    findall(L-Op, ( member(M, Ms), get_dict(line, M, L), get_dict(operator, M, Op) ), Pairs),
    assertion(\+ memberchk(4-cut_insert, Pairs)),
    assertion(memberchk(4-compare, Pairs)),
    assertion(memberchk(6-literal, Pairs)),
    assertion(\+ memberchk(8-_, Pairs)).

test(error_message) :-
    message_text(error(mutalog(no_test_files(['t/*.plt'], '/p')), _), S),
    assertion(sub_string(S, _, _, _, "No test files match t/*.plt (resolved against /p)")).

test(score) :-
    mutation_score([killed-3, timeout-1, survived-2, no_coverage-2], S, C),
    assertion(S =:= 50),
    assertion(C =:= 400/6),
    findall(S0-C0, mutation_score([killed-0, timeout-0, survived-0, no_coverage-0], S0, C0), Zero),
    assertion(Zero == [none-none]).

%   M3: the pool

id_statuses(Results, Pairs) :-
    findall(Id-S, ( member(r(M, S, _, _, _), Results), get_dict(id, M, Id) ), Pairs).

test(pool_matches_single_worker) :-
    project_dir(Dir),
    mutalog_run(Dir, [progress(false), concurrency(1)], run(_, R1, _, _)),
    mutalog_run(Dir, [progress(false), concurrency(3)], run(_, R3, _, _)),
    id_statuses(R1, P1),
    id_statuses(R3, P3),
    assertion(P1 == P3).

test(results_in_source_order) :-
    project_run(Results),
    findall(L-C, ( member(r(M, _, _, _, _), Results),
                   get_dict(line, M, L), get_dict(column, M, C) ), Pos),
    length(Pos, 55),
    msort(Pos, Sorted),
    assertion(Pos == Sorted).

test(worker_reuse) :-
    project_dir(Dir),
    mutalog_run(Dir, [progress(false), concurrency(2), worker_reuse(1)], run(_, R, _, _)),
    mutant_counts(R, Counts),
    assertion(memberchk(killed-35, Counts)),
    assertion(memberchk(survived-12, Counts)).

test(pool_size) :-
    mutalog_run:pool_size([concurrency(4)], [a, b], S1),
    assertion(S1 == 2),
    mutalog_run:pool_size([concurrency(2)], [a, b, c], S2),
    assertion(S2 == 2),
    mutalog_run:pool_size([concurrency(0)], [], S3),
    assertion(S3 == 1).

test(schedule_longest_first) :-
    mutalog_run:schedule([job(1, a, [], 10), job(2, b, [], 30), job(3, c, [], 10)], Jobs),
    assertion(Jobs == [job(2, b, [], 30), job(1, a, [], 10), job(3, c, [], 10)]).

%   A crash is reported as runtime_error once its retries are spent.

test(crash_is_runtime_error) :-
    tmp_project(Dir, "p(X) :- ( X =:= 1 -> true ; halt(3) ).\n",
                ":- use_module('../src/p').\n:- begin_tests(c).\ntest(one) :- p(1).\n:- end_tests(c).\n"),
    mutalog_run(Dir, [progress(false), operators([literal])], run(_, R, _, _)),
    assertion(status_of(R, 'src/p.pl:2:17:literal:1', runtime_error)),
    assertion(status_of(R, 'src/p.pl:2:34:literal:1', survived)).

%   The code under test catches every exception, including the time
%   limit, and loops again: only the hard limit can stop it.

test(swallowed_time_limit) :-
    tmp_project(Dir, "p(N) :- catch(count(N), _, count(N)).\ncount(0) :- !.\ncount(N) :- N1 is N - 1, count(N1).\n",
                ":- use_module('../src/p').\n:- begin_tests(s).\ntest(three) :- p(3).\n:- end_tests(s).\n"),
    mutalog_run(Dir, [progress(false), operators([arith]), timeout_ms(200)], run(_, R, _, _)),
    assertion(R = [r(_, timeout, _, _, _)]).

%   M4: reports

test(report_dict) :-
    project_dir(Dir),
    mutalog_run(Dir, [progress(false)], Run),
    report_dict(Run, D),
    assertion(D.schemaVersion == "2"),
    assertion(D.thresholds = _{high: 80, low: 60}),
    get_dict('src/calc.pl', D.files, F),
    length(F.mutants, 55),
    assertion(F.language == "prolog"),
    get_dict('test/calc.plt', D.testFiles, TF),
    length(TF.tests, 7),
    Tests = TF.tests,
    findall(Id, ( member(T, Tests), get_dict(id, T, Id) ), TestIds),
    Ms = F.mutants,
    assertion(forall(( member(M, Ms), get_dict(coveredBy, M, Cs), member(C, Cs) ),
                     memberchk(C, TestIds))),
    member(K, F.mutants), K.id == 'src/calc.pl:10:35:arith:1', !,
    assertion(K.status == "Killed"),
    assertion(K.killedBy == ["calc:sum"]),
    assertion(K.location.start = _{line: 10, column: 35}).

test(write_reports) :-
    project_dir(Dir),
    tmp_file(mutalog_reports, Out),
    mutalog_run(Dir, [progress(false), report_dir(Out), reporters([html, json])], Run),
    write_reports(Run, Written),
    length(Written, 2), !,
    directory_file_path(Out, 'mutation.html', Html),
    read_file_to_string(Html, Text, []),
    assertion(\+ sub_string(Text, _, _, _, "/*MUTALOG_REPORT*/null")),
    assertion(sub_string(Text, _, _, _, "src/calc.pl:10:35:arith:1")),
    directory_file_path(Out, 'mutation.json', Json),
    setup_call_cleanup(open(Json, read, In), json_read_dict(In, J), close(In)),
    assertion(J.schemaVersion == "2").

%   The pool's own code, run in this thread: the coverage run does not
%   record pool threads. Reuse 1 replaces the worker after every
%   mutant, and the crashing mutant is retried once on a fresh worker.

test(pool_thread_in_main_thread) :-
    tmp_project(Dir, "p(X) :- ( X =:= 1 -> true ; halt(3) ).\n",
                ":- use_module('../src/p').\n:- begin_tests(c).\ntest(one) :- p(1).\n:- end_tests(c).\n"),
    mutalog_dry_run(Dir, [operators([literal])], dry(_, [file(_, Ms, _)], _, Ctx, _)),
    findall(job(I, M, [c:one], 5000), nth1(I, Ms, M), Jobs),
    message_queue_create(JQ),
    message_queue_create(RQ),
    forall(member(J, Jobs), thread_send_message(JQ, J)),
    thread_send_message(JQ, done),
    mutalog_run:pool_thread(settings(Ctx, 1, 1), JQ, RQ),
    length(Jobs, NJobs),
    findall(Id-S, ( between(1, NJobs, _),
                    thread_get_message(RQ, done(_, r(M, S, _, _, _)), [timeout(0)]),
                    get_dict(id, M, Id) ), Pairs0),
    msort(Pairs0, Pairs1),
    include([Id-_]>>memberchk(Id, ['src/p.pl:2:17:literal:1', 'src/p.pl:2:34:literal:1']),
            Pairs1, Pairs),
    message_queue_destroy(JQ),
    message_queue_destroy(RQ),
    assertion(Pairs == [ 'src/p.pl:2:17:literal:1'-runtime_error,
                         'src/p.pl:2:34:literal:1'-survived ]).

%   No test enters the code, so there is nothing for the pool to run.

test(nothing_covered) :-
    tmp_project(Dir, "p(1).\n", ":- begin_tests(n).\ntest(none) :- true.\n:- end_tests(n).\n"),
    mutalog_run(Dir, [progress(false)], run(_, R, _, _)),
    assertion(R = [_|_]),
    assertion(forall(member(r(_, S, _, _, _), R), S == no_coverage)).

%   A worker that misses its deadline is killed.

test(worker_deadline) :-
    project_dir(Dir),
    worker_start(Dir, [], W),
    W = worker(Pid, In, Out),
    worker_call(W, init(Dir, [], ['test/calc.plt'], ['src/calc.pl']), 60, R0),
    assertion(R0 = ready(_)),
    worker_call(W, dry_run, 0, Reply),
    assertion(Reply == timeout),
    assertion(\+ is_stream(In)),
    assertion(\+ is_stream(Out)),
    catch(process_wait(Pid, _, [timeout(0)]), E, true),
    assertion(nonvar(E)),
    % Killing it again meets a reaped process and closed streams.
    assertion(mutalog_client:worker_kill(W)).

%   The worker protocol driven by hand: load a project file before the
%   tests, apply a mutant the tests kill, restore the original, and
%   the dry run passes again.

test(worker_restore) :-
    project_dir(Dir),
    mutalog_list(Dir, [mutate(['src/calc.pl'])], result([file(_, Ms, _)])),
    member(M, Ms), get_dict(id, M, 'src/calc.pl:10:35:arith:1'), !,
    worker_start(Dir, [], W),
    call_cleanup(
        ( worker_call(W, init(Dir, ['src/calc.pl'], ['test/calc.plt'], ['src/calc.pl']), 60, R0),
          assertion(R0 = ready(_)),
          worker_call(W, mutant(M.id, 'src/calc.pl', M.start, M.end, M.replacement,
                                [calc:sum], 10000), 60, R1),
          assertion(R1 = result(_, killed, calc:sum, _)),
          worker_call(W, restore, 60, R2),
          assertion(R2 == restored),
          worker_call(W, dry_run, 60, dry(Results)),
          assertion(forall(member(t(_, S, _, _), Results), S == passed)) ),
        worker_stop(W)).

test(error_messages) :-
    forall(member(E-Expected,
                  [ no_source_files(['s/*.pl'], '/p')-"No files to mutate match s/*.pl (resolved against /p)",
                    unknown_mutants([a, b])-"No mutant has the id a, b",
                    initial_test_run_failed([u:t])-"Tests fail before any mutant is applied: [u:t]",
                    worker_init(load_error(1))-"The worker could not load the project and its tests: load_error(1)",
                    dry_run(crashed)-"The dry run did not complete: crashed"
                  ]),
           ( phrase(prolog:error_message(mutalog(E)), Lines),
             lines_text(Lines, Text),
             assertion(sub_string(Text, 0, _, _, Expected)) )),
    phrase(prolog:message(mutalog(stale_ignore_mutants([a, b]))), Lines),
    lines_text(Lines, Text),
    assertion(sub_string(Text, 0, _, _, "ignore_mutants entries that match no mutant: a, b")).

tmp_project(Dir, Src, Test) :-
    tmp_file(mutalog_proj, Dir),
    make_directory(Dir),
    directory_file_path(Dir, src, SrcDir),
    directory_file_path(Dir, test, TestDir),
    make_directory(SrcDir),
    make_directory(TestDir),
    directory_file_path(SrcDir, 'p.pl', SrcFile),
    directory_file_path(TestDir, 'p.plt', TestFile),
    write_file(SrcFile, ":- module(p, [p/1]).\n"),
    append_file(SrcFile, Src),
    write_file(TestFile, Test).

:- end_tests(run).

:- begin_tests(cli).

test(all_options) :-
    findall(Opts0, mutalog:parse_options(['--config', 'c.pl', '--root', r, '--mutate', 'a/*.pl',
                           '--tests', 't/*.plt', '--operators', 'arith,cut',
                           '--format', json, '--check', '--only', 'x,y',
                           '--timeout-ms', '50', '--concurrency', '2', '-c', '3',
                           '--reporters', 'html,json', '--verbose'], Opts0),
            All),
    All = [Opts],
    assertion(Opts == [ config('c.pl'), root(r), mutate('a/*.pl'), tests('t/*.plt'),
                        operators([arith, cut]), format(json), check, only([x, y]),
                        timeout_ms(50), concurrency(2), concurrency(3),
                        reporters([html, json]), verbose(true) ]),
    mutalog:cli_overrides(Opts, Overrides),
    assertion(Overrides == [ config('c.pl'), operators([arith, cut]), root(r),
                             only([x, y]), timeout_ms(50), concurrency(2),
                             concurrency(3), reporters([html, json]), verbose(true),
                             tests(['t/*.plt']), mutate(['a/*.pl']) ]).

%   Nothing to say on a supported version.

test(check_version) :-
    stderr_text(mutalog:check_version, Text),
    assertion(Text == ""),
    stderr_text(mutalog:check_version(90000), Text0),
    assertion(Text0 == ""),
    stderr_text(mutalog:check_version(80610), Text1),
    assertion(sub_string(Text1, 0, _, _, "Warning: Mutalog needs SWI-Prolog 9.0 or later\n")).

test(percent_text, Ts == ['n/a'-'50.0%']) :-
    findall(A-B, ( mutalog:percent_text(none, A), mutalog:percent_text(50, B) ), Ts).

test(no_overrides, O == []) :-
    mutalog:cli_overrides([format(json), check], O).

test(unknown_option, error(domain_error(mutalog_option, '--bogus'))) :-
    mutalog:parse_options(['--check', '--bogus'], _).

test(unknown_command) :-
    stderr_text(findall(C, mutalog:run_cli([bogus, x], C), Codes), Text),
    assertion(Codes == [2]),
    assertion(sub_string(Text, 0, _, _, "mutalog: unknown command bogus\nUsage: mutalog run|dry-run|list")).

test(help) :-
    stderr_text(mutalog:run_cli([help], Code), Text),
    assertion(Code == 0),
    atomic_list_concat(
        [ "Usage: mutalog run|dry-run|list [OPTIONS]",
          "  --config FILE       config file (default mutalog.config.pl)",
          "  --root DIR          project root (default: the config file's directory)",
          "  --mutate GLOB       files to mutate, repeatable",
          "  --tests GLOB        test files, repeatable",
          "  --operators a,b     operators to use",
          "  --timeout-ms N      extra time per mutant",
          "  run:  --only ID,ID  run only these mutants",
          "        -c, --concurrency N  number of workers (default CPUs - 1)",
          "        --reporters a,b  clear_text, progress, html, json",
          "        --verbose     show the project's own output",
          "  list: --format text|json, --check",
          ""
        ], "\n", UsageA),
    atom_string(UsageA, Usage),
    assertion(Text == Usage),
    stderr_text(mutalog:run_cli([], Code0), Text0),
    assertion(Code0 == 0),
    assertion(Text0 == Text).

%   The command's output, run in this process.

lines_string(Lines, S) :-
    atomic_list_concat(Lines, "\n", S0),
    string_concat(S0, "\n", S).

test(list_output) :-
    fixtures_dir(Dir),
    with_output_to(string(Out),
                   mutalog:run_cli([list, '--root', Dir, '--mutate', 'cut_insert.pl'], Code)),
    assertion(Code == 0),
    lines_string([
        "cut_insert.pl: 10 mutants",
        "  cut_insert.pl:3:1:clause_drop:1",
        "      pick(X, Y) :- member(X, Y), X > 0.  ->  (removed)",
        "  cut_insert.pl:3:15:cut_insert:1",
        "      member(X, Y)  ->  (member(X, Y), !)",
        "  cut_insert.pl:3:15:goal_true:1",
        "      member(X, Y)  ->  true",
        "  cut_insert.pl:3:15:goal_fail:1",
        "      member(X, Y)  ->  fail",
        "  cut_insert.pl:3:29:compare:1",
        "      X > 0  ->  X >= 0",
        "  cut_insert.pl:3:29:compare:2",
        "      X > 0  ->  X =< 0",
        "  cut_insert.pl:3:29:goal_true:1",
        "      X > 0  ->  true",
        "  cut_insert.pl:3:29:goal_fail:1",
        "      X > 0  ->  fail",
        "  cut_insert.pl:3:33:literal:1",
        "      0  ->  1",
        "  cut_insert.pl:4:1:clause_drop:1",
        "      pick(_, none).  ->  (removed)",
        "",
        "Total: 10 mutants in 1 files",
        "  clause_drop   2",
        "  compare       2",
        "  cut_insert    1",
        "  goal_fail     2",
        "  goal_true     2",
        "  literal       1"
      ], Expected),
    assertion(Out == Expected).

test(list_json) :-
    fixtures_dir(Dir),
    with_output_to(string(Out),
                   mutalog:run_cli([list, '--root', Dir, '--mutate', 'cut_insert.pl',
                                    '--format', json, '--check'], Code)),
    assertion(Code == 0),
    open_string(Out, In),
    json_read_dict(In, J),
    J.files = [F],
    assertion(F.path == "cut_insert.pl"),
    length(F.mutants, 10),
    F.mutants = [M|_],
    del_dict(range, M, [Start, End], M1),
    assertion(End - Start =:= 34),
    assertion(M1 = _{ id: "cut_insert.pl:3:1:clause_drop:1", operator: "clause_drop",
                      location: _{ start: _{line: 3, column: 1},
                                    end: _{line: 3, column: 35} },
                       original: "pick(X, Y) :- member(X, Y), X > 0.",
                       replacement: "", check: "ok" }).

test(check_failure) :-
    stderr_text(mutalog:check_result(result([file(f, [], [a-ok, b-oops(1)])]), Code), Text),
    assertion(Code == 1),
    assertion(Text == "mutalog: b does not re-read: oops(1)\n"),
    mutalog:check_result(result([file(f, [], [a-ok])]), Code0),
    assertion(Code0 == 0).

test(run_output) :-
    project_dir(Dir),
    with_output_to(string(Out),
                   mutalog:run_cli([run, '--root', Dir, '--reporters', clear_text], Code)),
    assertion(Code == 0),
    lines_string([
        "",
        "Ran 7 tests in the dry run.",
        "",
        "Survived (12):",
        "  src/calc.pl:5:26:literal:1",
        "      0  ->  1",
        "      covered by 3 test(s)",
        "  src/calc.pl:5:29:cut:1",
        "      !  ->  true",
        "      covered by 3 test(s)",
        "  src/calc.pl:6:27:cut:1",
        "      !  ->  true",
        "      covered by 2 test(s)",
        "  src/calc.pl:13:11:literal:1",
        "      0  ->  1",
        "      covered by 1 test(s)",
        "  src/calc.pl:13:17:cut:1",
        "      !  ->  true",
        "      covered by 1 test(s)",
        "  src/calc.pl:14:17:compare:1",
        "      N > 0  ->  N >= 0",
        "      covered by 1 test(s)",
        "  src/calc.pl:14:17:goal_true:1",
        "      N > 0  ->  true",
        "      covered by 1 test(s)",
        "  src/calc.pl:14:24:goal_true:1",
        "      N1 is N - 1  ->  true",
        "      covered by 1 test(s)",
        "  src/calc.pl:14:37:goal_true:1",
        "      countdown(N1)  ->  true",
        "      covered by 1 test(s)",
        "  src/calc.pl:16:18:compare:1",
        "      X >= Y  ->  X > Y",
        "      covered by 1 test(s)",
        "  src/calc.pl:16:18:goal_true:1",
        "      X >= Y  ->  true",
        "      covered by 1 test(s)",
        "  src/calc.pl:16:26:cut:1",
        "      !  ->  true",
        "      covered by 1 test(s)",
        "",
        "Timed out (2):",
        "  src/calc.pl:14:30:arith:1",
        "      N - 1  ->  N + 1",
        "  src/calc.pl:14:34:literal:2",
        "      1  ->  -1",
        "",
        "File                                       Score  Killed   Surv. Timeout No cov.  Errors",
        "src/calc.pl                                67.3%      35      12       2       6       0",
        "All files                                  67.3%      35      12       2       6       0",
        "",
        "Mutation score: 67.3% (covered code: 75.5%)"
      ], Expected),
    assertion(Out == Expected).

test(dry_run_output) :-
    project_dir(Dir),
    with_output_to(string(Out), mutalog:run_cli(['dry-run', '--root', Dir], Code)),
    assertion(Code == 0),
    split_string(Out, "\n", "", Lines),
    Lines = ["Test                                                         Time (ms)   Clauses",
             Row1, _, _, _, _, _, _, "", "7 tests, 55 mutants", ""],
    assertion(sub_string(Row1, 0, _, _, "calc:sign_positive          ")),
    assertion(sub_string(Row1, _, _, 0, "         1  passed")),
    string_length(Row1, 88).

compile_error_result(Message, r(_{id: 'f.pl:1:1:cut:1', file: "f.pl", original: "!", replacement: "true"},
                                compile_error, load_error(Message), 0, [])).

test(compile_errors_output) :-
    compile_error_result("line one\nline two", R1),
    compile_error_result("", R2),
    with_output_to(string(Out), mutalog:print_compile_errors([R1, R2])),
    lines_string([ "", "Compile errors (2):",
                   "  f.pl: 2 mutant(s) did not load",
                   "      first error:",
                   "        line one",
                   "        line two" ], Expected),
    assertion(Out == Expected),
    with_output_to(string(Out2), mutalog:print_compile_errors([R2])),
    assertion(Out2 == "\nCompile errors (1):\n  f.pl: 1 mutant(s) did not load\n").

%   Most mutants not loading fails a positive break, and only warns
%   with break 0.

test(compile_errors_exit_code) :-
    compile_error_result("", R),
    Config = [thresholds(high(80), low(60), break(50))],
    stderr_text(mutalog:run_code(run(Config, [R, R], [], _), Code), Text),
    assertion(Code == 1),
    assertion(Text == "mutalog: no mutants were scored, so the break threshold 50% is not met\nmutalog: 2 of 2 mutants did not load (compile errors), so the run is probably broken\n"),
    stderr_text(mutalog:run_code(run([thresholds(high(80), low(60), break(0))], [R], [], _), Code0), Text0),
    assertion(Code0 == 0),
    assertion(sub_string(Text0, 0, _, _, "mutalog: 1 of 1 mutants did not load")),
    mutalog:run_code(run([], [R], [], _), Code1),
    assertion(Code1 == 0).

test(below_break) :-
    M = _{id: x, file: "f.pl"},
    stderr_text(mutalog:run_code(run([thresholds(high(80), low(60), break(50))],
                                     [r(M, killed, t, 0, []), r(M, survived, none, 0, []),
                                      r(M, survived, none, 0, [])], [], _), Code), Text),
    assertion(Code == 1),
    assertion(Text == "mutalog: score 33.3% is below break threshold 50%\n").

test(failing_dry_run) :-
    stderr_text(with_output_to(string(Out),
                               mutalog:print_dry_run(dry(_, [file(f, [a, b], s)],
                                                         [t(u:t, failed, 12, [k])], _, _), Code)),
                Err),
    assertion(Code == 1),
    assertion(Err == "mutalog: failing tests: [u:t]\n"),
    assertion(sub_string(Out, _, _, 0, "\n1 tests, 2 mutants\n")).

:- end_tests(cli).

:- begin_tests(internals).

%   A goal inside every meta-predicate argument is mutated as a goal.

test(meta_goal_args, Few == []) :-
    fixture_mutants('meta_goals.pl', [goal_true], Ms),
    findall(Line, ( between(6, 28, Line),
                    aggregate_all(count, ( member(M, Ms), get_dict(line, M, Line) ), N),
                    N < 2 ),
            Few).

test(soft_cut_is_no_cut, Rs == ["(a(X), !)"]) :-
    replacements('meta_goals.pl', cut_insert, Rs).

test(every_arith_swap,
     Rs == [ "max(A, max(A, A + A - A * A / A // A mod A rem A << A >> A))",
             "min(A, A + A - A * A / A // A mod A rem A << A >> A)",
             "A + A + A * A / A // A mod A rem A << A >> A",
             "A - A",
             "A * A / A // A mod A rem A << A << A",
             "A * A / A // A mod A rem A >> A",
             "A * A / A // A mod A * A",
             "A * A / A // A * A",
             "A * A / A * A",
             "A * A * A",
             "A / A" ]) :-
    replacements('all_ops.pl', arith, Rs).

test(every_compare_swap,
     Rs == [ "A =< B", "A >= B", "A >= B", "A =< B", "A < B", "A > B",
             "A > B", "A < B", "A =\\= B", "A =:= B",
             "A @=< B", "A @>= B", "A @>= B", "A @=< B", "A @< B", "A @> B",
             "A @> B", "A @< B" ]) :-
    replacements('all_ops.pl', compare, Rs).

%   A literal under a postfix operator from the file itself.

test(postfix_operand, Rs == ["2", "-1"]) :-
    replacements('all_ops.pl', literal, Rs).

test(term_text, T == "f(X, _, 1 + 2)") :-
    term_text(f(X, _, 1+2), ['X'=X], 999, T).

test(source_accessors) :-
    fixtures_dir(Dir),
    directory_file_path(Dir, 'all_ops.pl', File),
    read_source(File, Source),
    source_clauses(Source, Clauses),
    assertion(length(Clauses, 5)),
    source_op_module(Source, M),
    assertion(current_op(200, xf, M:percent)).

test(operator_descriptions) :-
    operator_names(Names),
    forall(member(N, Names),
           ( operator_description(N, D),
             assertion(string(D)) )).

%   Every status a run counts has a name in the report schema.

test(status_names,
     Names == [ killed-"Killed", survived-"Survived", timeout-"Timeout",
                no_coverage-"NoCoverage", compile_error-"CompileError",
                runtime_error-"RuntimeError", ignored-"Ignored" ]) :-
    mutant_counts([], Counts),
    findall(S-N, ( member(S-_, Counts), mutalog_report:status_name(S, N) ), Names).

test(progress_line) :-
    stderr_text(mutalog_run:report_progress(true, 3, 7, r(_{id: 'f.pl:1:1:cut:1'}, killed, none, 0, [])), T1),
    assertion(T1 == "[3/7] killed f.pl:1:1:cut:1\n"),
    stderr_text(findall(x, mutalog_run:report_progress(true, 1, 1, r(_{id: y}, killed, none, 0, [])), Xs), _),
    assertion(Xs == [x]),
    stderr_text(mutalog_run:report_progress(false, 3, 7, r(_{id: x}, killed, none, 0, [])), T2),
    assertion(T2 == "").

%   run_test/2 lets a time limit through to the caller and turns other
%   errors into a failed test.

test(time_limit_passes, E == time_limit_exceeded) :-
    catch(mutalog_coverage:test_exception(time_limit_exceeded), E, true).

test(other_error_fails, fail) :-
    mutalog_coverage:test_exception(error(type_error(integer, a), _)).

:- end_tests(internals).
