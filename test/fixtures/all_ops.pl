:- module(all_ops, [f/2, g/2, h/1]).
:- op(200, xf, percent).

f(A, X) :- X is min(A, max(A, A + A - A * A / A // A mod A rem A << A >> A)).

g(A, B) :-
    A < B, A > B, A =< B, A >= B, A =:= B, A =\= B,
    A @< B, A @> B, A @=< B, A @>= B.

h(X) :- X = 1 percent.
