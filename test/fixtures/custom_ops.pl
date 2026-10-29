:- module(custom_ops, [rule/2]).
:- op(700, xfx, ===>).

rule(A, B) :- A ===> B, A \== B.

A ===> B :- B = wrapped(A).
