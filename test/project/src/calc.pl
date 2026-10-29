% Fixture project for `mutalog run`. test/project/test/calc.plt tests
% most of it well, max2/3 weakly, and unused/1 not at all.
:- module(calc, [sign/2, sum/2, countdown/1, max2/3, unused/1]).

sign(X, positive) :- X > 0, !.
sign(X, zero) :- X =:= 0, !.
sign(_, negative).

sum([], 0).
sum([H|T], S) :- sum(T, S0), S is S0 + H.

% Changing N - 1 to N + 1 makes this loop: the mutant must time out.
countdown(0) :- !.
countdown(N) :- N > 0, N1 is N - 1, countdown(N1).

max2(X, Y, X) :- X >= Y, !.
max2(_, Y, Y).

unused(X) :- X = 1.
