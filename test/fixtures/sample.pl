% Fixture with hand-counted mutants. test/test_mutalog.plt asserts the
% count per operator; the comments below give the expected mutants.
:- module(sample, [classify/2, total/2, lookup/3, flag/1]).

% compare: < to =< and >=; literal: 10 to 11 and -10; cut: ! to true
classify(X, small) :- X < 10, !.
% compare: >= to > and <; literal: 10 to 11 and -10
classify(X, large) :- X >= 10.

% literal: [] to [_], 0 to 1
total([], 0).
% arith: + to -
total([H|T], S) :- total(T, S0), S is S0 + H.

% negate: the condition; unify: = to \=
lookup(Key, Pairs, Value) :-
    (   memberchk(Key-Value, Pairs)
    ->  true
    ;   Value = none
    ).

% negate: remove \+; unify: == to \==
flag(X) :- \+ X == off.

% Nothing in a test block is mutated.
:- begin_tests(sample).
test(a) :- classify(1, small).
:- end_tests(sample).
