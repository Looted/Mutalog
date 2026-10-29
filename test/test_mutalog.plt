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

:- begin_tests(run).

%   test/project has strong tests for most of calc.pl, a weak test for
%   max2/3, none for unused/1, and a mutant that loops forever.

project_dir(Dir) :-
    fixtures_dir(Fixtures),
    file_directory_name(Fixtures, TestDir),
    directory_file_path(TestDir, project, Dir).

project_run(Results) :-
    project_dir(Dir),
    mutalog_run(Dir, [progress(false)], run(_, Results, Tests)),
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
    mutalog_run(Dir, [progress(false), only(["src/calc.pl:14:30:arith:1"])], run(_, Results, _)),
    assertion(Results = [r(_, timeout, _, _, _)]).

test(dry_run_coverage) :-
    project_dir(Dir),
    mutalog_dry_run(Dir, [], dry(_, _, Results, _)),
    assertion(memberchk(t(calc:max_first, passed, _, ['src/calc.pl'-16]), Results)),
    assertion(\+ ( member(t(_, _, _, Cov), Results),
                   memberchk('src/calc.pl'-19, Cov) )).

test(initial_test_run_failed,
     error(mutalog(initial_test_run_failed([broken:fails])), _)) :-
    tmp_project(Dir, "p(1).\n", ":- use_module('../src/p').\n:- begin_tests(broken).\ntest(fails) :- p(2).\n:- end_tests(broken).\n"),
    mutalog_run(Dir, [progress(false)], _).

test(score) :-
    mutation_score([killed-3, timeout-1, survived-2, no_coverage-2], S, C),
    assertion(S =:= 50),
    assertion(C =:= 400/6),
    mutation_score([killed-0, timeout-0, survived-0, no_coverage-0], none, none).

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

write_file(File, Text) :-
    setup_call_cleanup(open(File, write, Out), write(Out, Text), close(Out)).
append_file(File, Text) :-
    setup_call_cleanup(open(File, append, Out), write(Out, Text), close(Out)).

:- end_tests(run).
