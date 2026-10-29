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
:- use_module(library(http/json)).
:- use_module(library(readutil)).
:- use_module(library(process)).

fixtures_dir(Dir) :-
    source_file(fixtures_dir(_), File),
    file_directory_name(File, TestDir),
    directory_file_path(TestDir, fixtures, Dir).

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

%   The text print_message/2 shows for Term, without printing it.

message_text(Term, Text) :-
    setup_call_cleanup(
        asserta((user:message_hook(Term, _, Lines) :-
                    with_output_to(string(S), print_message_lines(current_output, '', Lines)),
                    nb_setval(mutalog_message, S)), Ref),
        print_message(error, Term),
        erase(Ref)),
    nb_getval(mutalog_message, Text).

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

test(discover, Files == ['custom_ops.pl', 'cut_insert.pl', 'sample.pl', 'spacing.pl']) :-
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
    assertion(config_value(root, CA, ConfDir)),
    load_config(Dir, [config('conf/b.config.pl')], CB),
    assertion(config_value(root, CB, ProjDir)),
    load_config(Dir, [config('conf/b.config.pl'), root(conf)], CC),
    assertion(config_value(root, CC, ConfDir)).

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

%   test/project has strong tests for most of calc.pl, a weak test for
%   max2/3, none for unused/1, and a mutant that loops forever.

project_dir(Dir) :-
    fixtures_dir(Fixtures),
    file_directory_name(Fixtures, TestDir),
    directory_file_path(TestDir, project, Dir).

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
    mutation_score([killed-0, timeout-0, survived-0, no_coverage-0], none, none).

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
