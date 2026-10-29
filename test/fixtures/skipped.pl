:- module(skipped, [greeting//0, ok/0]).
:- dynamic counter/1.

greeting --> "hello", " ", "world".

ok :- true.
