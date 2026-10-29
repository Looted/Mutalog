%   Reload a module over a previous version of itself, the way the
%   worker applies one mutant after another, and print how often a
%   dropped clause still answered: 0 when reloading is sound. Used by
%   the worker tests in test_mutalog.plt.

:- use_module('../prolog/mutalog/worker').
:- use_module(library(lists)).
:- use_module(library(aggregate)).

main :-
    tmp_file(mutalog_reload, Dir),
    make_directory(Dir),
    aggregate_all(sum(N), ( between(1, 10, I), stale_reloads(Dir, I, N) ), Stale),
    format("~q.~n", [Stale]).

stale_reloads(Dir, I, Stale) :-
    format(atom(Module), 'mutalog_reload_~d', [I]),
    format(atom(Base), '~w.pl', [Module]),
    directory_file_path(Dir, Base, File),
    format(string(Header), ":- module(~w, [check/2]).", [Module]),
    atomic_list_concat(
        [ Header,
          "check(Lo, Hi) :- ne(interval(Lo, open, Hi, open, [])).",
          "ne(interval(ninf, _, _, _, _)) :- !.",
          "ne(interval(_, _, pinf, _, _)) :- !.",
          "ne(interval(Lo, _, Hi, _, _)) :- Lo < Hi, !.",
          "ne(interval(Lo, closed, Hi, closed, Excluded)) :-",
          "    Lo =:= Hi,",
          "    \\+ ( member(Value, Excluded), Value =:= Lo ).",
          ""
        ], "\n", Text),
    write_file(File, Text),
    use_module(File, []),
    replace_once(Text, "check(Lo, Hi) :- ne", "check(Lo, Hi) :- true, ne", First),
    replace_once(Text, "ne(interval(Lo, _, Hi, _, _)) :- Lo < Hi, !.\n", "", Dropped),
    aggregate_all(count,
                  ( between(1, 5, _),
                    mutalog_worker:reload(File, First, ok),
                    Module:check(1, 2),
                    mutalog_worker:reload(File, Dropped, ok),
                    Module:check(1, 2)
                  ),
                  Stale).

replace_once(S, Old, New, Out) :-
    sub_string(S, B, _, A, Old),
    !,
    sub_string(S, 0, B, _, Pre),
    sub_string(S, _, A, 0, Post),
    atomics_to_string([Pre, New, Post], Out).

write_file(File, Text) :-
    setup_call_cleanup(open(File, write, Out), write(Out, Text), close(Out)).
