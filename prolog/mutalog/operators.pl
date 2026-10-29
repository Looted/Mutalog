:- module(mutalog_operators,
          [ operator_names/1,        % -Names
            operator_description/2,  % ?Name, -Description
            site_mutation/4          % +Ops, +Site, +Term, -Op-Mutated
          ]).

/** <module> Mutation operators

Every operator is a clause of the multifile hooks mutalog:operator/2 and
mutalog:mutate/4, so a project can add its own operator from its config
or a loaded file without forking the pack:

```
:- multifile mutalog:operator/2, mutalog:mutate/4.
mutalog:operator(my_op, "What it changes").
mutalog:mutate(my_op, site(goal, _Flags), Goal0, Goal) :- ...
```

A site is `site(Context, Flags)`. Context is one of

  - `goal`  a goal in a clause body;
  - `cond`  the condition of an if-then-else, as a whole;
  - `arith` a subterm of an arithmetic expression;
  - `data`  any other argument term, in a head or a goal.

Flags is a list that may contain `first_goal` (the leftmost goal of the
body), `cut_insertable` (a non-last clause of a multi-clause predicate
whose body has no cut).

`clause_drop` is generated at clause level by the generator and only
registered here so that it is known to the configuration.
*/

:- use_module(library(lists)).
:- use_module(library(apply)).

:- discontiguous mutalog:mutate/4.
:- multifile
    mutalog:operator/2,
    mutalog:mutate/4.

mutalog:operator(arith,       "Swap an arithmetic operator: + and -, * and /, // mod rem to *, min and max, unary minus removed").
mutalog:operator(compare,     "Move an arithmetic or standard-order comparison across its boundary or flip it").
mutalog:operator(unify,       "Swap = and \\=, == and \\==, =@= and \\=@=").
mutalog:operator(negate,      "Remove a \\+, or negate the condition of an if-then-else").
mutalog:operator(cut,         "Remove a cut").
mutalog:operator(cut_insert,  "Insert a cut after the first goal of a non-last clause that has none").
mutalog:operator(goal_true,   "Replace a body goal with true").
mutalog:operator(goal_fail,   "Replace a body goal with fail").
mutalog:operator(clause_drop, "Remove one clause of a multi-clause predicate").
mutalog:operator(literal,     "Change a number, string, boolean atom or empty list").

%!  operator_names(-Names) is det.

operator_names(Names) :-
    findall(N, mutalog:operator(N, _), Names0),
    sort(Names0, Names).

operator_description(Name, Description) :-
    mutalog:operator(Name, Description).

%!  site_mutation(+Ops, +Site, +Term, -Mutation) is nondet.
%
%   Mutation is Op-Mutated for every enabled operator in Ops that
%   applies to Term at Site. Mutations that leave the term unchanged
%   are dropped.

site_mutation(Ops, Site, Term, Op-Mutated) :-
    member(Op, Ops),
    Op \== clause_drop,
    catch(mutalog:mutate(Op, Site, Term, Mutated), _, fail),
    Mutated \=@= Term.

%   ---------------------------------------------------------------
%   arith

mutalog:mutate(arith, site(arith, _), T0, T) :-
    compound(T0),
    compound_name_arguments(T0, F0, Args),
    (   Args = [_, _],
        arith_swap(F0, F),
        compound_name_arguments(T, F, Args)
    ;   Args = [X],
        F0 == (-),
        T = X
    ).

arith_swap(+,   -).
arith_swap(-,   +).
arith_swap(*,   /).
arith_swap(/,   *).
arith_swap(//,  *).
arith_swap(mod, *).
arith_swap(rem, *).
arith_swap(min, max).
arith_swap(max, min).
arith_swap(<<,  >>).
arith_swap(>>,  <<).

%   ---------------------------------------------------------------
%   compare

mutalog:mutate(compare, site(goal, _), G0, G) :-
    compound(G0),
    compound_name_arguments(G0, F0, [A, B]),
    compare_swap(F0, Fs),
    member(F, Fs),
    compound_name_arguments(G, F, [A, B]).

compare_swap(<,    [=<, >=]).
compare_swap(>,    [>=, =<]).
compare_swap(=<,   [<, >]).
compare_swap(>=,   [>, <]).
compare_swap(=:=,  [=\=]).
compare_swap(=\=,  [=:=]).
compare_swap(@<,   [@=<, @>=]).
compare_swap(@>,   [@>=, @=<]).
compare_swap(@=<,  [@<, @>]).
compare_swap(@>=,  [@>, @<]).

%   ---------------------------------------------------------------
%   unify

mutalog:mutate(unify, site(goal, _), G0, G) :-
    compound(G0),
    compound_name_arguments(G0, F0, [A, B]),
    unify_swap(F0, F),
    compound_name_arguments(G, F, [A, B]).

unify_swap(=,    \=).
unify_swap(\=,   =).
unify_swap(==,   \==).
unify_swap(\==,  ==).
unify_swap(=@=,  \=@=).
unify_swap(\=@=, =@=).

%   ---------------------------------------------------------------
%   negate

mutalog:mutate(negate, site(goal, _), \+ G, G) :-
    !.
mutalog:mutate(negate, site(cond, _), C, \+ C) :-
    C \= (\+ _).

%   ---------------------------------------------------------------
%   cut and cut_insert
%
%   An inserted cut after a goal with one solution changes nothing, so
%   cut_insert is a separate operator that a project can switch off.

mutalog:mutate(cut, site(goal, _), G, true) :-
    G == !.
mutalog:mutate(cut_insert, site(goal, Flags), G, (G, !)) :-
    G \== !,
    memberchk(first_goal, Flags),
    memberchk(cut_insertable, Flags).

%   ---------------------------------------------------------------
%   goal_true and goal_fail

mutalog:mutate(goal_true, site(goal, _), G, true) :-
    \+ memberchk_eq(G, [true, !]).
mutalog:mutate(goal_fail, site(goal, _), G, fail) :-
    \+ memberchk_eq(G, [fail, false]).

memberchk_eq(X, List) :-
    member(Y, List),
    X == Y,
    !.

%   ---------------------------------------------------------------
%   literal

mutalog:mutate(literal, site(Ctx, _), L0, L) :-
    memberchk(Ctx, [data, arith]),
    literal_swap(L0, L).

literal_swap(N, M) :-
    integer(N),
    !,
    (   N =:= 0
    ->  M = 1
    ;   (   M is N + 1
        ;   M is -N
        )
    ).
literal_swap(N, M) :-
    float(N),
    !,
    (   N =:= 0.0
    ->  M = 1.0
    ;   (   M is N + 1.0
        ;   M is -N
        )
    ).
literal_swap(S, M) :-
    string(S),
    !,
    (   S == ""
    ->  M = "mutalog"
    ;   M = ""
    ).
literal_swap(A, M) :-
    A == true,
    !,
    M = false.
literal_swap(A, M) :-
    A == false,
    !,
    M = true.
literal_swap(A, [_]) :-
    A == [].
