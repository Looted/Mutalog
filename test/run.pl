% Run the Mutalog test suite: swipl test/run.pl
:- initialization(run_all, main).

:- use_module(library(plunit)).
:- set_prolog_flag(encoding, utf8).

%   A syntax error in a test file drops the clause and loading goes on,
%   so count error messages while loading and fail the run on any.

:- dynamic load_errors/1.
load_errors(0).

:- multifile user:message_hook/3.
user:message_hook(_, error, _) :-
    retract(load_errors(N)),
    N1 is N + 1,
    assertz(load_errors(N1)),
    fail.

:- load_files('test_mutalog.plt', []).
:- retract(load_errors(N)), assertz(loaded_with_errors(N)).

run_all :-
    loaded_with_errors(Errors),
    (   Errors =:= 0,
        run_tests
    ->  halt(0)
    ;   halt(1)
    ).
