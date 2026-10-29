:- module(mutalog,
          [ main/0,
            mutalog_list/3          % +Root, +Overrides, -Result
          ]).

/** <module> Mutalog: mutation testing for SWI-Prolog

Mutalog changes the code under test in small ways (a flipped comparison,
a removed cut, a dropped clause) and checks that the plunit suite
notices. It follows Stryker's model and vocabulary.

This version implements the first stage: reading sources and listing
mutants. Command line:

```
mutalog list [--config FILE] [--mutate GLOB]... [--operators a,b]
             [--format text|json] [--check]
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
run_cli([Cmd|_], 2) :-
    Cmd \== help,
    !,
    format(user_error, "mutalog: unknown command ~w~n", [Cmd]),
    usage.
run_cli(_, 0) :-
    usage.

usage :-
    format(user_error,
           "Usage: mutalog list [--config FILE] [--mutate GLOB]... \c
            [--operators a,b] [--format text|json] [--check]~n", []).

parse_options([], []).
parse_options(['--config', F|T], [config(F)|Os]) :- !, parse_options(T, Os).
parse_options(['--mutate', G|T], [mutate(G)|Os]) :- !, parse_options(T, Os).
parse_options(['--operators', L|T], [operators(Ops)|Os]) :-
    !,
    atomic_list_concat(Ops, ',', L),
    parse_options(T, Os).
parse_options(['--format', F|T], [format(F)|Os]) :- !, parse_options(T, Os).
parse_options(['--check'|T], [check|Os]) :- !, parse_options(T, Os).
parse_options([X|_], _) :-
    domain_error(mutalog_option, X).

cli_overrides(Opts, Overrides) :-
    findall(G, member(mutate(G), Opts), Globs),
    (   Globs == []
    ->  O1 = []
    ;   O1 = [mutate(Globs)]
    ),
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

file_mutants(Root, Ops, IgnoreIds, Rel, file(Rel, Mutants, Checks)) :-
    directory_file_path(Root, Rel, Path),
    read_source(Path, Source),
    source_mutants(Source, Rel, Ops, Mutants0),
    exclude(ignored_mutant(IgnoreIds), Mutants0, Mutants),
    findall(Id-R,
            ( member(M, Mutants),
              get_dict(id, M, Id),
              verify_mutant(Source, M, R)
            ),
            Checks).

ignored_mutant(IgnoreIds, M) :-
    memberchk(M.id, IgnoreIds).

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
%   Output

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
