:- module(mutalog_report,
          [ report_dict/2,           % +Run, -Dict
            write_reports/2          % +Run, -Written
          ]).

/** <module> Report files

Builds the JSON report of a run and writes the file reporters named in
the `reporters` config key into `report_dir`:

  - `json`: `mutation.json`, in the open mutation-testing report
    schema (schema version 2), so any viewer of that format can read it
  - `html`: `mutation.html`, a single self-contained page with the same
    data and no network access

The `clear_text` and `progress` reporters print to the terminal and are
handled by the command line and the run loop.
*/

:- use_module(library(lists)).
:- use_module(library(apply)).
:- use_module(library(pairs)).
:- use_module(library(readutil)).
:- use_module(library(http/json)).
:- use_module(config).
:- use_module(reader).

:- prolog_load_context(directory, Dir),
   directory_file_path(Dir, 'report.html', Template),
   asserta(html_template(Template)).

%!  write_reports(+Run, -Written) is det.
%
%   Written is the list of report files written.

write_reports(Run, Written) :-
    Run = run(Config, _, _, _),
    config_value(reporters, Config, Reporters),
    include(file_reporter, Reporters, FileReporters),
    (   FileReporters == []
    ->  Written = []
    ;   report_dict(Run, Dict),
        config_value(root, Config, Root),
        config_value(report_dir, Config, Dir0),
        atom_string(DirA, Dir0),
        directory_file_path(Root, DirA, Dir),
        make_directory_path(Dir),
        maplist(write_report(Dir, Dict), FileReporters, Written)
    ).

file_reporter(json).
file_reporter(html).

write_report(Dir, Dict, json, File) :-
    directory_file_path(Dir, 'mutation.json', File),
    setup_call_cleanup(
        open(File, write, Out, [encoding(utf8)]),
        json_write_dict(Out, Dict, [width(0)]),
        close(Out)).
write_report(Dir, Dict, html, File) :-
    directory_file_path(Dir, 'mutation.html', File),
    html_template(Template),
    read_file_to_string(Template, Html0, [encoding(utf8)]),
    with_output_to(string(Json0), json_write_dict(current_output, Dict, [width(0)])),
    %   Keep the data from closing the script element it sits in.
    split_string_all(Json0, "</", "<\\/", Json),
    split_string_all(Html0, "/*MUTALOG_REPORT*/null", Json, Html),
    setup_call_cleanup(
        open(File, write, Out, [encoding(utf8)]),
        write(Out, Html),
        close(Out)).

split_string_all(S0, Pattern, Replacement, S) :-
    atomic_list_concat(Parts, Pattern, S0),
    atomic_list_concat(Parts, Replacement, A),
    atom_string(A, S).

%!  report_dict(+Run, -Dict) is det.
%
%   The run as a dict in the mutation-testing report schema.

report_dict(run(Config, Results, _, info(Files, TestInfo, Timing)), Dict) :-
    memberchk(thresholds(high(High), low(Low), _), Config),
    config_value(root, Config, Root0),
    absolute_file_name(Root0, Root),
    pack_version(Version),
    maplist(file_entry(Results), Files, FilePairs),
    dict_pairs(FilesDict, _, FilePairs),
    test_files(TestInfo, TestFiles),
    Timing = timing(DryMs, MutMs),
    Dict = _{ schemaVersion: "2",
              thresholds: _{high: High, low: Low},
              projectRoot: Root,
              files: FilesDict,
              testFiles: TestFiles,
              framework: _{name: "mutalog", version: Version},
              performance: _{setup: 0, initialRun: DryMs, mutation: MutMs}
            }.

pack_version(Version) :-
    module_property(mutalog_report, file(File)),
    file_directory_name(File, D1),
    file_directory_name(D1, D2),
    file_directory_name(D2, PackDir),
    directory_file_path(PackDir, 'pack.pl', Pack),
    (   exists_file(Pack),
        catch(setup_call_cleanup(open(Pack, read, In),
                                 read_version(In, V),
                                 close(In)), _, fail)
    ->  atom_string(V, Version)
    ;   Version = "unknown"
    ).

read_version(In, V) :-
    read_term(In, T, []),
    (   T == end_of_file
    ->  fail
    ;   T = version(V)
    ->  true
    ;   read_version(In, V)
    ).

file_entry(Results, file(Rel, _, Source), Key-Entry) :-
    atom_string(Key, Rel),
    source_text(Source, Text),
    include(result_in(Rel), Results, Rs),
    maplist(mutant_entry, Rs, Mutants),
    Entry = _{language: "prolog", source: Text, mutants: Mutants}.

result_in(Rel, r(M, _, _, _, _)) :-
    get_dict(file, M, Rel).

mutant_entry(r(M, Status, KilledBy, Ms, Covering), Entry) :-
    status_name(Status, Name),
    maplist(test_id, Covering, CoveredBy),
    get_dict(id, M, Id),
    get_dict(operator, M, Op),
    get_dict(replacement, M, Repl),
    Location = _{ start: _{line: M.line, column: M.column},
                  end: _{line: M.end_line, column: M.end_column} },
    E0 = _{ id: Id, mutatorName: Op, replacement: Repl,
            location: Location, status: Name, coveredBy: CoveredBy,
            duration: Ms, static: false },
    (   Status == killed, KilledBy \== none
    ->  test_id(KilledBy, K),
        Entry = E0.put(killedBy, [K])
    ;   KilledBy = load_error(Message), Message \== ""
    ->  Entry = E0.put(statusReason, Message)
    ;   Entry = E0
    ).

status_name(killed, "Killed").
status_name(survived, "Survived").
status_name(timeout, "Timeout").
status_name(no_coverage, "NoCoverage").
status_name(compile_error, "CompileError").
status_name(runtime_error, "RuntimeError").
status_name(ignored, "Ignored").

test_id(Test, Id) :-
    format(string(Id), "~w", [Test]).

test_files(TestInfo, Dict) :-
    findall(File-T,
            ( member(test(Test, File0, Line0), TestInfo),
              ( File0 == none -> File = '' ; File = File0 ),
              ( integer(Line0) -> Line = Line0 ; Line = 1 ),
              test_id(Test, Id),
              T = _{id: Id, name: Id,
                    location: _{start: _{line: Line, column: 1}}}
            ),
            Pairs0),
    keysort(Pairs0, Pairs),
    group_pairs_by_key(Pairs, Grouped),
    findall(K-_{tests: Ts}, member(K-Ts, Grouped), DictPairs),
    dict_pairs(Dict, _, DictPairs).
