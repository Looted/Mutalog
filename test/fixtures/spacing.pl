:- module(spacing, [indicator/1, step/2]).

indicator(f/1).
step(X, Y) :- Y is X-1.
