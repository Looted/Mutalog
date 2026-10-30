%   End-to-end tests: each one runs Mutalog the way a user does, as the
%   bin/mutalog command (or an installed pack) in a separate process, on
%   a project in a temporary directory, and checks what the user sees:
%   the output, the exit code and the report files.

:- use_module(library(plunit)).
:- use_module(library(lists)).
:- use_module(library(apply)).
:- use_module(library(process)).
:- use_module(library(readutil)).
:- use_module(library(filesex)).
:- use_module(library(http/json)).

:- begin_tests(e2e).

repo_dir(Dir) :-
    source_file(repo_dir(_), File),
    file_directory_name(File, TestDir),
    file_directory_name(TestDir, Dir).

repo_path(Rel, Path) :-
    repo_dir(Dir),
    directory_file_path(Dir, Rel, Path).

%   Run Exe with Args in Dir and capture the exit code and both output
%   streams.

run_process(Exe, Args, Dir, Env, Exit, Out, Err) :-
    tmp_file(out, OutFile),
    tmp_file(err, ErrFile),
    setup_call_cleanup(
        ( open(OutFile, write, O), open(ErrFile, write, E) ),
        ( process_create(Exe, Args,
                         [ cwd(Dir), stdout(stream(O)), stderr(stream(E)),
                           process(Pid) | Env ]),
          process_wait(Pid, Status) ),
        ( close(O), close(E) )),
    Status = exit(Exit),
    read_file_to_string(OutFile, Out, []),
    read_file_to_string(ErrFile, Err, []).

mutalog(Dir, Args, Exit, Out, Err) :-
    repo_path('bin/mutalog', Bin),
    run_process(Bin, Args, Dir, [], Exit, Out, Err).

mutalog(Dir, Args, Exit, Out) :-
    mutalog(Dir, Args, Exit, Out, _).

swipl(Dir, Args, Exit, Out, Err) :-
    run_process(path(swipl), Args, Dir, [], Exit, Out, Err).

new_dir(Dir) :-
    tmp_file(mutalog_e2e, Dir),
    make_directory(Dir).

write_file(File, Text) :-
    file_directory_name(File, D),
    make_directory_path(D),
    setup_call_cleanup(open(File, write, Out), write(Out, Text), close(Out)).

%   A copy of the example project in test/project.

example_project(Dir) :-
    repo_path('test/project', Src),
    new_dir(Dir),
    copy_directory(Src, Dir).

%   A project with one module src/p.pl and one test file test/p.plt.

project(Dir, Src, Test, Config) :-
    new_dir(Dir),
    directory_file_path(Dir, 'src/p.pl', SrcFile),
    directory_file_path(Dir, 'test/p.plt', TestFile),
    directory_file_path(Dir, 'mutalog.config.pl', ConfigFile),
    write_file(SrcFile, Src),
    write_file(TestFile, Test),
    write_file(ConfigFile, Config).

fixtures_list(File, Ops, Mutants) :-
    repo_path('test/fixtures', Dir),
    atomic_list_concat(Ops, ',', OpList),
    mutalog(Dir, [list, '--mutate', File, '--operators', OpList,
                  '--format', json, '--check'], 0, Out),
    atom_json_dict(Out, J, [value_string_as(string)]),
    json_mutants(J, Mutants).

changes(Mutants, Changes) :-
    findall(O-R, ( member(M, Mutants),
                   get_dict(original, M, O0), get_dict(replacement, M, R0),
                   atom_string(O, O0), atom_string(R, R0) ),
            Changes).

%   All mutants of a `mutalog list --format json` result.

json_mutants(J, Mutants) :-
    get_dict(files, J, Files),
    findall(M, ( member(F, Files), get_dict(mutants, F, Ms), member(M, Ms) ),
            Mutants).

%   Field values of each mutant, for use inside findall/forall where
%   M.key would be evaluated before M is bound.

field(Key, M, V) :-
    get_dict(Key, M, V).

read_json(File, Dict) :-
    setup_call_cleanup(open(File, read, In), json_read_dict(In, Dict), close(In)).

json_report(Dir, Report) :-
    directory_file_path(Dir, 'reports/mutation/mutation.json', File),
    read_json(File, Report).

report_mutant(Report, Id, Mutant) :-
    member(F, Report.files.'src/calc.pl'.mutants),
    atom_string(Id, F.id),
    !,
    Mutant = F.

report_mutant_in(Report, File, Id, Mutant) :-
    get_dict(File, Report.files, F),
    member(Mutant, F.mutants),
    atom_string(Id, Mutant.id),
    !.

lines(File, Lines) :-
    read_file_to_string(File, S, []),
    split_string(S, "\n", "", Ls0),
    exclude(==(""), Ls0, Lines).

%   Listing mutants

id_matches(F, M) :-
    split_string(M.id, ":", "", [File, L, C, Op, N]),
    assertion(File == F.path),
    assertion(number_string(M.location.start.line, L)),
    assertion(number_string(M.location.start.column, C)),
    assertion(Op == M.operator),
    assertion(number_string(_, N)).

test(list_prints_mutants_without_running) :-
    example_project(Dir),
    mutalog(Dir, [list], 0, Out),
    assertion(sub_string(Out, _, _, _, "src/calc.pl: 55 mutants")),
    assertion(sub_string(Out, _, _, _, "X > 0  ->  X >= 0")),
    directory_file_path(Dir, reports, Reports),
    assertion(\+ exists_directory(Reports)).

test(list_check_rereads_every_mutant) :-
    example_project(Dir),
    mutalog(Dir, [list, '--check', '--format', json], 0, Out),
    atom_json_dict(Out, J, [value_string_as(string)]),
    json_mutants(J, Ms),
    maplist(field(check), Ms, Checks),
    length(Checks, 55),
    assertion(forall(member(C, Checks), C == "ok")).

test(mutant_ids_name_file_line_column_operator) :-
    example_project(Dir),
    mutalog(Dir, [list, '--format', json], 0, Out),
    atom_json_dict(Out, J, [value_string_as(string)]),
    forall(( member(F, J.files), get_dict(mutants, F, Ms), member(M, Ms) ),
           id_matches(F, M)),
    json_mutants(J, All),
    maplist(field(id), All, Ids),
    sort(Ids, Unique),
    assertion(length(Ids, 55)),
    assertion(length(Unique, 55)).

%   Operators, on the hand-counted fixture test/fixtures/sample.pl

test(operator_arith) :-
    fixtures_list('sample.pl', [arith], Ms),
    changes(Ms, Cs),
    assertion(Cs == ['S0 + H'-'S0 - H']).

test(operator_compare) :-
    fixtures_list('sample.pl', [compare], Ms),
    changes(Ms, Cs),
    assertion(memberchk('X < 10'-'X =< 10', Cs)),
    assertion(memberchk('X < 10'-'X >= 10', Cs)),
    assertion(memberchk('X >= 10'-'X > 10', Cs)),
    assertion(memberchk('X >= 10'-'X < 10', Cs)).

test(operator_unify) :-
    fixtures_list('sample.pl', [unify], Ms),
    changes(Ms, Cs),
    assertion(memberchk('Value = none'-'Value \\= none', Cs)),
    assertion(memberchk('X == off'-'X \\== off', Cs)).

test(operator_negate) :-
    fixtures_list('sample.pl', [negate], Ms),
    changes(Ms, Cs),
    assertion(memberchk('memberchk(Key-Value, Pairs)'-'\\+ memberchk(Key-Value, Pairs)', Cs)),
    assertion(memberchk('\\+ X == off'-'X == off', Cs)).

test(operator_cut) :-
    fixtures_list('sample.pl', [cut], Ms),
    changes(Ms, Cs),
    assertion(Cs == ['!'-true]),
    fixtures_list('cut_insert.pl', [cut_insert], Ins),
    changes(Ins, InsCs),
    assertion(InsCs = [_-'(member(X, Y), !)']).

test(operator_goal_true) :-
    fixtures_list('sample.pl', [goal_true], Ms),
    changes(Ms, Cs),
    assertion(memberchk('total(T, S0)'-true, Cs)),
    assertion(forall(member(_-R, Cs), R == true)).

test(operator_goal_fail) :-
    fixtures_list('sample.pl', [goal_fail], Ms),
    changes(Ms, Cs),
    assertion(memberchk('total(T, S0)'-fail, Cs)),
    assertion(forall(member(_-R, Cs), R == fail)).

test(operator_clause_drop) :-
    fixtures_list('sample.pl', [clause_drop], Ms),
    length(Ms, 4),
    maplist(field(replacement), Ms, Rs),
    assertion(forall(member(R, Rs), R == "")).

test(operator_literal) :-
    fixtures_list('sample.pl', [literal], Ms),
    changes(Ms, Cs),
    assertion(memberchk('10'-'11', Cs)),
    assertion(memberchk('10'-'-10', Cs)),
    assertion(memberchk('[]'-'[_]', Cs)),
    assertion(memberchk('0'-'1', Cs)).

test(custom_operator_from_a_project) :-
    new_dir(Dir),
    directory_file_path(Dir, 'src/p.pl', Src),
    write_file(Src, ":- module(p, [p/1]).\np(X) :- succ_or_zero(X).\nsucc_or_zero(X) :- X >= 0.\n"),
    directory_file_path(Dir, 'my_ops.pl', Ops),
    write_file(Ops, ":- multifile mutalog:operator/2, mutalog:mutate/4.\nmutalog:operator(always_true, \"Replace a goal with true\").\nmutalog:mutate(always_true, site(goal, _), G, true) :- G \\== true.\n"),
    repo_path('prolog/mutalog.pl', Lib),
    format(atom(Use), "use_module('~w')", [Lib]),
    swipl(Dir, [ '-q', '-g', Use, '-g', 'consult(my_ops)',
                 '-g', 'mutalog:main', '-t', 'halt(2)', '--',
                 list, '--mutate', 'src/p.pl', '--operators', always_true,
                 '--format', json ],
          0, Out, _),
    atom_json_dict(Out, J, [value_string_as(string)]),
    json_mutants(J, Ms),
    maplist(field(operator), Ms, Opers),
    assertion(Opers = [_|_]),
    assertion(forall(member(O, Opers), O == "always_true")).

test(never_mutates_directives_dcg_or_tests) :-
    fixtures_list('skipped.pl', [arith, compare, unify, negate, cut, cut_insert,
                                 goal_true, goal_fail, clause_drop, literal], Ms),
    maplist(field(original), Ms, Os),
    assertion(\+ ( member(O, Os), sub_string(O, _, _, _, "hello") )),
    new_dir(Dir),
    directory_file_path(Dir, 'src/p.pl', Src),
    write_file(Src, ":- module(p, [p/1, g//0]).\n:- dynamic q/1.\ng --> [a], [b].\np(X) :- X > 1.\n:- begin_tests(p).\ntest(p) :- p(2).\n:- end_tests(p).\n"),
    mutalog(Dir, [list, '--mutate', 'src/p.pl', '--format', json], 0, Out),
    atom_json_dict(Out, J, [value_string_as(string)]),
    json_mutants(J, Ms2),
    findall(L, ( member(M, Ms2), get_dict(location, M, Loc),
                 get_dict(start, Loc, St), get_dict(line, St, L) ), Lines),
    assertion(Lines \== []),
    assertion(forall(member(L, Lines), L =:= 4)).

test(reads_custom_operators_and_syntax) :-
    fixtures_list('custom_ops.pl', [arith, compare, unify, negate, goal_true, literal], Ms),
    assertion(Ms \== []),
    maplist(field(check), Ms, Cs),
    assertion(forall(member(C, Cs), C == "ok")).

test(mutates_itself) :-
    repo_dir(Root),
    mutalog(Root, [list, '--mutate', 'prolog/**/*.pl', '--check', '--format', json], 0, Out),
    atom_json_dict(Out, J, [value_string_as(string)]),
    length(J.files, NFiles),
    assertion(NFiles >= 10),
    json_mutants(J, Ms),
    maplist(field(check), Ms, Cs),
    assertion(forall(member(C, Cs), C == "ok")),
    repo_path('test/run.pl', Run),
    read_file_to_string(Run, RunText, []),
    assertion(sub_string(RunText, _, _, _, "library(plunit)")).

%   Configuration

test(config_file_is_optional_and_read) :-
    example_project(Dir),
    directory_file_path(Dir, 'mutalog.config.pl', Config),
    delete_file(Config),
    mutalog(Dir, [list, '--mutate', 'src/*.pl'], 0, Out0),
    assertion(sub_string(Out0, _, _, _, "src/calc.pl: 55 mutants")),
    write_file(Config, "mutate([\"src/*.pl\"]).\noperators([arith]).\n"),
    mutalog(Dir, [list], 0, Out1),
    assertion(sub_string(Out1, _, _, _, "src/calc.pl: 2 mutants")).

%   Dry run

test(dry_run_records_time_and_clauses) :-
    example_project(Dir),
    mutalog(Dir, ['dry-run'], 0, Out),
    split_string(Out, "\n", "", Lines),
    member(Line, Lines),
    sub_string(Line, 0, _, _, "calc:max_first"),
    !,
    split_string(Line, " ", " ", Fields0),
    exclude(==(""), Fields0, Fields),
    Fields = ["calc:max_first", Ms, Clauses, Status],
    assertion(number_string(_, Ms)),
    assertion(Clauses == "1"),
    assertion(Status == "passed"),
    assertion(sub_string(Out, _, _, _, "7 tests, 55 mutants")).

test(failing_test_stops_the_run) :-
    project(Dir, ":- module(p, [p/1]).\np(1).\n",
            ":- use_module('../src/p').\n:- begin_tests(broken).\ntest(fails) :- p(2).\n:- end_tests(broken).\n",
            "mutate([\"src/*.pl\"]).\ntests([\"test/*.plt\"]).\n"),
    mutalog(Dir, [run], Exit, _, Err),
    assertion(Exit == 2),
    assertion(sub_string(Err, _, _, _, "broken:fails")),
    directory_file_path(Dir, 'reports/mutation/mutation.json', Json),
    assertion(\+ exists_file(Json)).

%   Running mutants on the example project

test(run_reports_statuses_and_score) :-
    example_project(Dir),
    mutalog(Dir, [run], 0, Out),
    assertion(sub_string(Out, _, _, _, "Mutation score: 67.3% (covered code: 75.5%)")),
    json_report(Dir, R),
    findall(S, ( member(M, R.files.'src/calc.pl'.mutants), S = M.status ), Ss),
    msort(Ss, Sorted),
    clumped_pairs(Sorted, Counts),
    assertion(Counts == ["Killed"-35, "NoCoverage"-6, "Survived"-12, "Timeout"-2]),
    % (killed + timeout) / (killed + timeout + survived + no coverage)
    assertion(abs((35+2)/(35+2+12+6)*100 - 67.27) < 0.01).

clumped_pairs([], []).
clumped_pairs([H|T], [H-N|R]) :-
    take_same(H, T, 1, N, Rest),
    clumped_pairs(Rest, R).
take_same(H, [H1|T], N0, N, Rest) :-
    H1 == H, !,
    N1 is N0 + 1,
    take_same(H, T, N1, N, Rest).
take_same(_, Rest, N, N, Rest).

test(uncovered_mutants_are_not_run) :-
    example_project(Dir),
    mutalog(Dir, [run, '--reporters', json], 0, _),
    json_report(Dir, R),
    report_mutant(R, 'src/calc.pl:19:14:unify:1', M),
    assertion(M.status == "NoCoverage"),
    assertion(M.coveredBy == []),
    assertion(\+ get_dict(killedBy, M, [_|_])).

test(runs_only_covering_tests) :-
    example_project(Dir),
    mutalog(Dir, [run, '--reporters', json], 0, _),
    json_report(Dir, R),
    report_mutant(R, 'src/calc.pl:10:35:arith:1', M),
    assertion(M.status == "Killed"),
    assertion(M.killedBy == ["calc:sum"]),
    msort(M.coveredBy, Covered),
    assertion(Covered == ["calc:sum"]).

%   The example project's modules are static and never declared
%   dynamic, so a mutant can only be applied by reloading the file.

test(applies_mutants_to_static_code) :-
    example_project(Dir),
    directory_file_path(Dir, 'src/calc.pl', Src),
    read_file_to_string(Src, Before, []),
    mutalog(Dir, [run, '--reporters', json, '--operators', arith], 0, _),
    read_file_to_string(Src, After, []),
    assertion(Before == After),
    json_report(Dir, R),
    report_mutant(R, 'src/calc.pl:10:35:arith:1', M),
    assertion(M.status == "Killed"),
    assertion(\+ sub_string(Before, _, _, _, "dynamic")).

test(time_limit_from_dry_run) :-
    example_project(Dir),
    get_time(T0),
    mutalog(Dir, [run, '--reporters', json, '--operators', arith,
                  '--timeout-ms', 300], 0, _),
    get_time(T1),
    json_report(Dir, R),
    report_mutant(R, 'src/calc.pl:14:30:arith:1', M),
    assertion(M.status == "Timeout"),
    assertion(T1 - T0 < 10).

%   The code under test catches the time limit and loops again: only
%   the controller's hard limit can stop it.

test(hard_limit_stops_a_swallowed_time_limit) :-
    project(Dir, ":- module(p, [p/1]).\np(N) :- catch(count(N), _, count(N)).\ncount(0) :- !.\ncount(N) :- N1 is N - 1, count(N1).\n",
            ":- use_module('../src/p').\n:- begin_tests(s).\ntest(three) :- p(3).\n:- end_tests(s).\n",
            "mutate([\"src/*.pl\"]).\ntests([\"test/*.plt\"]).\noperators([arith]).\ntimeout_ms(200).\n"),
    get_time(T0),
    mutalog(Dir, [run, '--reporters', json], 0, _),
    get_time(T1),
    json_report(Dir, R),
    get_dict('src/p.pl', R.files, F),
    assertion(F.mutants = [_]),
    F.mutants = [M],
    assertion(M.status == "Timeout"),
    assertion(T1 - T0 < 40).

%   A mutant that halts its worker: each attempt appends to a log, so
%   the log shows the retries, and the run still finishes.

crash_project(Dir, Log, Retries) :-
    new_dir(Dir),
    directory_file_path(Dir, 'attempts.log', Log),
    format(string(Test),
           ":- use_module('../src/p').\n:- begin_tests(c).\ntest(one) :- setup_call_cleanup(open(~q, append, S), format(S, \"one~~n\", []), close(S)), p(1).\n:- end_tests(c).\n",
           [Log]),
    format(string(Config),
           "mutate([\"src/*.pl\"]).\ntests([\"test/*.plt\"]).\noperators([literal]).\nretries(~w).\n",
           [Retries]),
    directory_file_path(Dir, 'src/p.pl', SrcFile),
    directory_file_path(Dir, 'test/p.plt', TestFile),
    directory_file_path(Dir, 'mutalog.config.pl', ConfigFile),
    write_file(SrcFile, ":- module(p, [p/1]).\np(X) :- ( X =:= 1 -> true ; halt(3) ).\n"),
    write_file(TestFile, Test),
    write_file(ConfigFile, Config).

crash_attempts(Retries, Attempts, R) :-
    crash_project(Dir, Log, Retries),
    mutalog(Dir, [run, '--reporters', json], 0, _),
    json_report(Dir, R),
    lines(Log, Lines),
    length(Lines, Attempts).

test(crash_is_isolated_in_a_worker_process) :-
    crash_attempts(1, _, R),
    get_dict('src/p.pl', R.files, F),
    report_mutant_in(R, 'src/p.pl', 'src/p.pl:2:17:literal:1', Crashed),
    assertion(Crashed.status == "RuntimeError"),
    report_mutant_in(R, 'src/p.pl', 'src/p.pl:2:34:literal:1', Other),
    assertion(Other.status == "Survived"),
    length(F.mutants, N),
    assertion(N >= 2).

test(crash_is_retried_on_a_fresh_worker) :-
    crash_attempts(0, A0, _),
    crash_attempts(2, A2, R),
    get_dict('src/p.pl', R.files, F),
    include([M]>>get_dict(status, M, "RuntimeError"), F.mutants, Crashed),
    length(Crashed, NCrashed),
    assertion(NCrashed >= 1),
    % Two more attempts of each crashing mutant with retries(2).
    assertion(A2 - A0 =:= 2 * NCrashed).

%   Mutants with the longest time limit start first: with one worker,
%   the slow test's mutants run before the fast test's, although the
%   fast predicate comes first in the file.

test(longest_limits_start_first) :-
    new_dir(Dir),
    directory_file_path(Dir, 'order.log', Log),
    format(string(Test),
           ":- use_module('../src/p').\nlog(W) :- setup_call_cleanup(open(~q, append, S), format(S, \"~~w~~n\", [W]), close(S)).\n:- begin_tests(o).\ntest(fast) :- log(fast), fast(1).\ntest(slow) :- log(slow), sleep(0.3), slow(1).\n:- end_tests(o).\n",
           [Log]),
    directory_file_path(Dir, 'src/p.pl', SrcFile),
    directory_file_path(Dir, 'test/p.plt', TestFile),
    directory_file_path(Dir, 'mutalog.config.pl', ConfigFile),
    write_file(SrcFile, ":- module(p, [fast/1, slow/1]).\nfast(X) :- X > 0.\nslow(X) :- X > 0.\n"),
    write_file(TestFile, Test),
    write_file(ConfigFile, "mutate([\"src/*.pl\"]).\ntests([\"test/*.plt\"]).\noperators([compare]).\nconcurrency(1).\n"),
    mutalog(Dir, [run, '--reporters', json], 0, _),
    lines(Log, Lines),
    % The dry run runs each test once, in file order.
    assertion(Lines = ["fast", "slow"|_]),
    Lines = [_, _|Mutants],
    assertion(Mutants = ["slow", "slow", "fast"|_]).

test(only_runs_the_chosen_mutants) :-
    example_project(Dir),
    mutalog(Dir, [run, '--only', 'src/calc.pl:10:35:arith:1'], 0, Out),
    assertion(sub_string(Out, _, _, _, "Killed")),
    json_report(Dir, R),
    assertion(R.files.'src/calc.pl'.mutants = [_]),
    R.files.'src/calc.pl'.mutants = [M],
    assertion(M.status == "Killed").

%   Reports and thresholds

test(break_threshold_sets_the_exit_code) :-
    example_project(Dir),
    directory_file_path(Dir, 'mutalog.config.pl', Config),
    write_file(Config, "mutate([\"src/*.pl\"]).\ntests([\"test/*.plt\"]).\ntimeout_ms(1000).\nthresholds(high(80), low(60), break(90)).\n"),
    mutalog(Dir, [run, '--reporters', clear_text], Below, _),
    assertion(Below == 1),
    write_file(Config, "mutate([\"src/*.pl\"]).\ntests([\"test/*.plt\"]).\ntimeout_ms(1000).\nthresholds(high(80), low(60), break(50)).\n"),
    mutalog(Dir, [run, '--reporters', clear_text], Above, _),
    assertion(Above == 0).

%   A mutated module that another mutated module imports. Each mutant
%   is loaded over the previous one in the same worker, and every one
%   must load: generated mutants always parse.

test(mutates_a_module_another_module_imports) :-
    new_dir(Dir),
    write_in(Dir, 'src/a.pl', ":- module(a, [double/2]).\ndouble(X, Y) :- Y is X * 2.\n"),
    write_in(Dir, 'src/b.pl', ":- module(b, [quad/2]).\n:- use_module(a).\nquad(X, Y) :- double(X, Z), double(Z, Y).\n"),
    write_in(Dir, 'test/a.plt', ":- use_module('../src/a').\n:- begin_tests(a).\ntest(double) :- double(4, Y), Y =:= 8.\n:- end_tests(a).\n"),
    write_in(Dir, 'test/b.plt', ":- use_module('../src/b').\n:- begin_tests(b).\ntest(quad) :- quad(3, Y), Y =:= 12.\n:- end_tests(b).\n"),
    write_in(Dir, 'mutalog.config.pl', "mutate([\"src/*.pl\"]).\nconcurrency(1).\n"),
    mutalog(Dir, [run, '--reporters', 'clear_text,json'], Exit, Out),
    assertion(Exit == 0),
    assertion(\+ sub_string(Out, _, _, _, "Compile errors")),
    json_report(Dir, R),
    forall(( get_dict(_, R.files, F), member(M, F.mutants) ),
           assertion(M.status == "Killed")).

%   Two mutated modules that export the same name: reloading one must
%   not clash with the other.

test(mutates_modules_that_export_the_same_name) :-
    new_dir(Dir),
    write_in(Dir, 'src/a.pl', ":- module(a, [f/2]).\nf(X, Y) :- Y is X + 1.\n"),
    write_in(Dir, 'src/c.pl', ":- module(c, [f/2]).\nf(X, Y) :- Y is X * 3.\n"),
    write_in(Dir, 'test/a.plt', ":- use_module('../src/a', []).\n:- begin_tests(a).\ntest(f) :- a:f(1, Y), Y =:= 2.\n:- end_tests(a).\n"),
    write_in(Dir, 'test/c.plt', ":- use_module('../src/c', []).\n:- begin_tests(c).\ntest(f) :- c:f(2, Y), Y =:= 6.\n:- end_tests(c).\n"),
    write_in(Dir, 'mutalog.config.pl', "mutate([\"src/*.pl\"]).\nconcurrency(1).\n"),
    mutalog(Dir, [run, '--reporters', 'clear_text,json'], Exit, Out),
    assertion(Exit == 0),
    assertion(\+ sub_string(Out, _, _, _, "Compile errors")),
    json_report(Dir, R),
    forall(( get_dict(_, R.files, F), member(M, F.mutants) ),
           assertion(M.status == "Killed")).

%   A mutant that drops the clause a test needs is killed, even after
%   earlier mutants of the same predicate ran in the same worker.

test(dropped_clause_mutant_is_killed) :-
    new_dir(Dir),
    write_in(Dir, 'src/m.pl', ":- module(m, [check/2]).\ncheck(Lo, Hi) :- ne(interval(Lo, open, Hi, open, [])).\nne(interval(ninf, _, _, _, _)) :- !.\nne(interval(_, _, pinf, _, _)) :- !.\nne(interval(Lo, _, Hi, _, _)) :- Lo < Hi, !.\nne(interval(Lo, closed, Hi, closed, Excluded)) :-\n    Lo =:= Hi,\n    \\+ ( member(Value, Excluded), Value =:= Lo ).\n"),
    write_in(Dir, 'test/m.plt', ":- use_module('../src/m').\n:- begin_tests(m).\ntest(lt) :- check(1, 2).\n:- end_tests(m).\n"),
    write_in(Dir, 'mutalog.config.pl', "mutate([\"src/*.pl\"]).\nconcurrency(1).\noperators([goal_true, clause_drop]).\n"),
    mutalog(Dir, [run, '--reporters', json], _, _),
    json_report(Dir, R),
    get_dict(_, R.files, F),
    member(M, F.mutants),
    M.mutatorName == "clause_drop",
    M.location.start.line == 5,
    !,
    assertion(M.status == "Killed").

%   A run in which most mutants don't load is broken, whatever its
%   score: it fails a positive break threshold and shows the first
%   load error. Here q.pl throws whenever it is loaded again.

test(mostly_compile_errors_fails_the_break) :-
    new_dir(Dir),
    write_in(Dir, 'src/p.pl', ":- module(p, [p/2]).\np(X, Y) :- Y is X + 1.\n"),
    write_in(Dir, 'src/q.pl', ":- module(q, [q/2]).\n:- ( flag(q_loads, N, N + 1), N > 0 -> throw(error(reloaded_q, _)) ; true ).\nq(X, Y) :- Y is X * 2, Y > 0.\nq(_, 0).\n"),
    write_in(Dir, 'test/p.plt', ":- use_module('../src/p').\n:- use_module('../src/q').\n:- begin_tests(p).\ntest(p) :- p(1, Y), Y =:= 2.\ntest(q) :- q(2, Y), Y =:= 4.\ntest(q0) :- q(-1, Y), Y =:= 0.\n:- end_tests(p).\n"),
    write_in(Dir, 'mutalog.config.pl', "mutate([\"src/*.pl\"]).\nconcurrency(1).\nthresholds(high(80), low(60), break(50)).\n"),
    mutalog(Dir, [run, '--reporters', 'clear_text,json'], Exit, Out, Err),
    assertion(Exit == 1),
    assertion(sub_string(Out, _, _, _, "Compile errors")),
    assertion(sub_string(Out, _, _, _, "reloaded_q")),
    assertion(sub_string(Err, _, _, _, "did not load")),
    json_report(Dir, R),
    forall(member(M, R.files.'src/q.pl'.mutants),
           ( assertion(M.status == "CompileError"),
             assertion(sub_string(M.statusReason, _, _, _, "reloaded_q")) )).

write_in(Dir, Rel, Text) :-
    directory_file_path(Dir, Rel, File),
    write_file(File, Text).

test(html_report_is_self_contained) :-
    example_project(Dir),
    mutalog(Dir, [run, '--reporters', html], 0, _),
    directory_file_path(Dir, 'reports/mutation/mutation.html', Html),
    read_file_to_string(Html, Text, []),
    assertion(sub_string(Text, _, _, _, "src/calc.pl:10:35:arith:1")),
    assertion(\+ sub_string(Text, _, _, _, "src=\"http")),
    assertion(\+ sub_string(Text, _, _, _, "href=\"http")),
    assertion(\+ sub_string(Text, _, _, _, "@import")),
    assertion(\+ sub_string(Text, _, _, _, "fetch(")).

test(json_report_follows_schema_v2) :-
    example_project(Dir),
    mutalog(Dir, [run, '--reporters', json], 0, _),
    json_report(Dir, R),
    assertion(R.schemaVersion == "2"),
    assertion(R.thresholds = _{high: _, low: _}),
    get_dict('src/calc.pl', R.files, F),
    assertion(F.language == "prolog"),
    assertion(string(F.source)),
    forall(member(M, F.mutants), schema_mutant(M)).

schema_mutant(M) :-
    assertion(string(M.id)),
    assertion(string(M.mutatorName)),
    assertion(_{line: _, column: _} :< M.location.start),
    assertion(_{line: _, column: _} :< M.location.end),
    assertion(memberchk(M.status, ["Killed", "Survived", "Timeout",
                                   "NoCoverage", "CompileError",
                                   "RuntimeError", "Ignored"])).

%   Packaging

%   The files a pack archive needs, copied without the rest of the
%   checkout, as pack_install/2 sees a release.

pack_source(Dir) :-
    new_dir(Dir),
    forall(member(F, ['pack.pl', 'LICENSE']),
           ( repo_path(F, From), directory_file_path(Dir, F, To), copy_file(From, To) )),
    forall(member(D, [prolog, app, bin]),
           ( repo_path(D, From), directory_file_path(Dir, D, To), copy_directory(From, To) )).

install_pack(Packs) :-
    pack_source(Src),
    new_dir(Packs),
    format(atom(Goal),
           "pack_install('file://~w', [interactive(false), package_directory('~w')])",
           [Src, Packs]),
    swipl(Src, ['-q', '-g', Goal, '-t', halt], 0, _, _).

test(installs_as_a_pack) :-
    install_pack(Packs),
    example_project(Dir),
    format(atom(Attach), "attach_packs('~w', [])", [Packs]),
    swipl(Dir, ['-q', '-g', Attach, '-g', 'use_module(library(mutalog))',
                '-g', 'mutalog:main', '-t', 'halt(2)', '--', list],
          0, Out, _),
    assertion(sub_string(Out, _, _, _, "src/calc.pl: 55 mutants")).

read_all(In, Ts) :-
    read_term(In, T, []),
    (   T == end_of_file
    ->  Ts = []
    ;   Ts = [T|Rest],
        read_all(In, Rest)
    ).

test(pack_needs_only_swi_prolog) :-
    repo_path('pack.pl', PackFile),
    setup_call_cleanup(open(PackFile, read, In), read_all(In, Ts0), close(In)),
    findall(R, member(requires(R), Ts0), Requires),
    assertion(forall(member(R, Requires), R = (prolog >= _))),
    install_pack(Packs),
    format(atom(Attach), "attach_packs('~w', [])", [Packs]),
    % Ask where the pack is rather than assume Packs: the layout of the
    % pack directory differs between versions.
    Report = 'pack_property(mutalog, directory(D)), forall(( source_file(F), sub_atom(F, 0, _, _, D) ), (file_name_extension(_, Ext, F), writeln(Ext)))',
    swipl(Packs, ['-q', '-g', Attach, '-g', 'use_module(library(mutalog))',
                  '-g', Report, '-t', halt],
          0, Out, _),
    split_string(Out, "\n", "", Exts0),
    exclude(==(""), Exts0, Exts),
    (   Exts == []
    ->  format(user_error, "No pack file loaded; pack directory and loaded files:~n", []),
        format(atom(Dump),
               "forall(pack_property(mutalog, directory(D)), writeln(D)), forall(( source_file(F), sub_atom(F, _, _, _, mutalog) ), writeln(F))",
               []),
        swipl(Packs, ['-q', '-g', Attach, '-g', 'use_module(library(mutalog))',
                      '-g', Dump, '-t', halt], _, DumpOut, _),
        format(user_error, "~s~n", [DumpOut])
    ;   true
    ),
    assertion(Exts \== []),
    assertion(forall(member(E, Exts), E == "pl")).

test(pack_has_no_node_dependency) :-
    pack_source(Src),
    directory_files(Src, Top),
    assertion(\+ memberchk('package.json', Top)),
    forall(( member(D, [prolog, app, bin]),
             directory_file_path(Src, D, Dir),
             directory_member(Dir, File, [recursive(true)]) ),
           ( file_name_extension(_, Ext, File),
             assertion(memberchk(Ext, [pl, html, ''])) )),
    repo_path('bin/mutalog', Bin),
    read_file_to_string(Bin, Script, []),
    assertion(\+ sub_string(Script, _, _, _, "node")),
    assertion(\+ sub_string(Script, _, _, _, "npm")).

%   Releasing

release_checkout(Dir, Version) :-
    new_dir(Dir),
    forall(member(F, ['pack.pl', 'CHANGELOG.md', 'scripts/release-check.sh',
                      'scripts/release-notes.sh']),
           ( repo_path(F, From), directory_file_path(Dir, F, To),
             file_directory_name(To, ToDir), make_directory_path(ToDir),
             copy_file(From, To) )),
    directory_file_path(Dir, 'scripts/release-notes.sh', Notes),
    chmod(Notes, +x),
    repo_path('pack.pl', PackFile),
    read_file_to_string(PackFile, Pack, []),
    sub_string(Pack, B, _, _, "version('"),
    S is B + 9,
    sub_string(Pack, S, _, 0, Rest),
    sub_string(Rest, E, _, _, "'"), !,
    sub_string(Rest, 0, E, _, Version).

test(release_check_requires_a_changelog_section) :-
    release_checkout(Dir, Version),
    run_process(path(bash), ['scripts/release-check.sh'], Dir, [], 0, Out, _),
    assertion(split_string(Out, "", "\n", [Version])),
    directory_file_path(Dir, 'pack.pl', PackFile),
    read_file_to_string(PackFile, Pack, []),
    format(string(Old), "version('~w')", [Version]),
    sub_string(Pack, B, _, A, Old), !,
    sub_string(Pack, 0, B, _, Pre),
    sub_string(Pack, _, A, 0, Post),
    string_concat(Pre, "version('99.0.0')", P1),
    string_concat(P1, Post, NewPack),
    write_file(PackFile, NewPack),
    run_process(path(bash), ['scripts/release-check.sh'], Dir, [], Exit, _, Err),
    assertion(Exit =\= 0),
    assertion(sub_string(Err, _, _, _, "CHANGELOG.md has no '## 99.0.0' section")).

git(Dir, Args) :-
    run_process(path(git), Args, Dir, [], 0, _, _).

test(release_refuses_a_tagged_version) :-
    release_checkout(Dir, Version),
    new_dir(Origin),
    git(Origin, [init, '-q', '--bare']),
    git(Dir, [init, '-q']),
    git(Dir, ['-c', 'user.name=t', '-c', 'user.email=t@t', add, '.']),
    git(Dir, ['-c', 'user.name=t', '-c', 'user.email=t@t', commit, '-q', '-m', release]),
    git(Dir, [remote, add, origin, Origin]),
    git(Dir, [push, '-q', origin, 'HEAD:refs/heads/master']),
    run_process(path(bash), ['scripts/release-check.sh', '--untagged'], Dir, [], 0, _, _),
    atom_concat(v, Version, Tag),
    git(Dir, [tag, Tag]),
    git(Dir, [push, '-q', origin, Tag]),
    run_process(path(bash), ['scripts/release-check.sh', '--untagged'], Dir, [], Exit, _, Err),
    assertion(Exit =\= 0),
    format(string(Msg), "tag ~w already exists", [Tag]),
    assertion(sub_string(Err, _, _, _, Msg)).

%   `changeset version` bumps package.json and writes the new section
%   under the changelog's title; the version step must carry the bump
%   into pack.pl and give the section the layout of the others.

test(version_step_syncs_pack_and_changelog) :-
    release_checkout(Dir, Version),
    repo_path('scripts/sync-version.mjs', Sync),
    directory_file_path(Dir, 'scripts/sync-version.mjs', SyncTo),
    copy_file(Sync, SyncTo),
    directory_file_path(Dir, 'package.json', Npm),
    write_file(Npm, "{\n  \"name\": \"mutalog\",\n  \"version\": \"99.1.0\"\n}\n"),
    directory_file_path(Dir, 'CHANGELOG.md', Log),
    read_file_to_string(Log, Old, []),
    sub_string(Old, T, _, _, "\n"), !,
    sub_string(Old, 0, T, _, Title),
    sub_string(Old, T, _, 0, Intro),
    format(string(New),
           "~w\n\n## 99.1.0\n\n### Minor Changes\n\n- A feature.\n\n  Its details.\n\n### Patch Changes\n\n- A fix.\n~w",
           [Title, Intro]),
    write_file(Log, New),
    run_process(path(node), ['scripts/sync-version.mjs', '2026-01-02'], Dir, [], 0, _, _),
    run_process(path(bash), ['scripts/release-check.sh'], Dir, [], 0, Out, _),
    assertion(split_string(Out, "", "\n", ["99.1.0"])),
    read_file_to_string(Log, Synced, []),
    assertion(\+ sub_string(Synced, _, _, _, "### ")),
    format(string(Prev), "\n## ~w ", [Version]),
    sub_string(Synced, P, _, _, Prev), !,
    sub_string(Synced, S, _, _, "\n## 99.1.0 (2026-01-02)\n\n- A feature.\n\n  Its details.\n\n- A fix.\n"), !,
    assertion(S < P),
    sub_string(Synced, 0, S, _, Head),
    assertion(Head \== Title),
    run_process(path(bash), ['scripts/release-notes.sh', '99.1.0'], Dir, [], 0, Notes, _),
    assertion(Notes == "- A feature.\n\n  Its details.\n\n- A fix.\n").

:- end_tests(e2e).
