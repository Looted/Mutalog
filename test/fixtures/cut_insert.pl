:- module(cut_insert, [pick/2]).

pick(X, Y) :- member(X, Y), X > 0.
pick(_, none).
