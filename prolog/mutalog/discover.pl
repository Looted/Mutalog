:- module(mutalog_discover,
          [ discover_files/4,       % +Root, +Patterns, +Ignore, -Files
            glob_match/2            % +Pattern, +RelPath
          ]).

/** <module> Source discovery

Expands `mutate` and `ignore` globs relative to the project root. Globs
use `/` as separator, `*`, `?`, `[...]` and `{a,b}` within one path
segment, and `**` for any number of segments, as in Stryker.
*/

:- use_module(library(lists)).
:- use_module(library(apply)).
:- use_module(library(filesex)).

%!  discover_files(+Root, +Patterns, +Ignore, -Files) is det.
%
%   Files is the sorted list of relative paths (atoms) under Root that
%   match one of Patterns and none of Ignore.

discover_files(Root, Patterns, Ignore, Files) :-
    findall(Rel,
            ( member(Pattern, Patterns),
              pattern_files(Root, Pattern, Rel),
              \+ ( member(I, Ignore), glob_match(I, Rel) )
            ),
            Files0),
    sort(Files0, Files).

pattern_files(Root, Pattern0, Rel) :-
    atom_string(Pattern0, PatternS),
    split_string(PatternS, "/", "", Segments0),
    exclude(==(""), Segments0, Segments1),
    exclude(==("."), Segments1, Segments),
    literal_prefix(Segments, Prefix, _),
    atomic_list_concat(Prefix, '/', PrefixPath),
    (   Prefix == []
    ->  Start = Root
    ;   directory_file_path(Root, PrefixPath, Start)
    ),
    (   Prefix \== [], exists_file(Start)
    ->  Rel = PrefixPath,
        glob_match(Pattern0, Rel)
    ;   exists_directory(Start),
        walk(Start, Root, Rel),
        glob_match(Pattern0, Rel)
    ).

literal_prefix([S|Ss], [S|Ps], Rest) :-
    \+ wild_segment(S),
    !,
    literal_prefix(Ss, Ps, Rest).
literal_prefix(Rest, [], Rest).

wild_segment(S) :-
    sub_string(S, _, 1, _, C),
    memberchk(C, ["*", "?", "[", "{"]),
    !.

walk(Dir, Root, Rel) :-
    directory_files(Dir, Entries),
    member(E, Entries),
    \+ memberchk(E, ['.', '..', '.git', node_modules]),
    directory_file_path(Dir, E, Path),
    (   exists_directory(Path)
    ->  walk(Path, Root, Rel)
    ;   exists_file(Path),
        relative_path(Root, Path, Rel)
    ).

relative_path(Root, Path, Rel) :-
    absolute_file_name(Root, AbsRoot0),
    absolute_file_name(Path, AbsPath),
    (   sub_atom(AbsRoot0, _, 1, 0, '/')
    ->  RootSlash = AbsRoot0
    ;   atom_concat(AbsRoot0, '/', RootSlash)
    ),
    (   atom_concat(RootSlash, Rel, AbsPath)
    ->  true
    ;   Rel = AbsPath
    ).

%!  glob_match(+Pattern, +RelPath) is semidet.

glob_match(Pattern, Rel) :-
    once(glob_match_(Pattern, Rel)).

glob_match_(Pattern, Rel) :-
    atom_string(Pattern, PS),
    atom_string(Rel, RS),
    split_string(PS, "/", "", PSeg0),
    exclude(==("."), PSeg0, PSeg),
    split_string(RS, "/", "", RSeg),
    match_segments(PSeg, RSeg).

match_segments([], []).
match_segments(["**"|Ps], Rs) :-
    !,
    (   match_segments(Ps, Rs)
    ;   Rs = [_|Rs1],
        match_segments(["**"|Ps], Rs1)
    ).
match_segments([P|Ps], [R|Rs]) :-
    atom_string(PA, P),
    atom_string(RA, R),
    wildcard_match(PA, RA),
    match_segments(Ps, Rs).
