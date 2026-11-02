:- module(skipped, [greeting//0, ok/0]).
:- dynamic counter/1.

greeting --> "hello", " ", "world".

ok :- true.

?- true.

:- begin_tests(skipped, []).
test(inside) :- X = 1, X > 0.
:- end_tests(skipped).
