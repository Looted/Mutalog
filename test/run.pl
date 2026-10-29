% Run the Mutalog test suite: swipl test/run.pl
% Run some tests only:         swipl test/run.pl e2e:operator_arith
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

:- load_files(['test_mutalog.plt', 'test_e2e.plt'], []).
:- retract(load_errors(N)), assertz(loaded_with_errors(N)).

run_all :-
    current_prolog_flag(argv, Argv),
    maplist(test_spec, Argv, Specs),
    loaded_with_errors(Errors),
    (   Errors =:= 0,
        run_specs(Specs)
    ->  halt(0)
    ;   halt(1)
    ).

%   A unit name, or Unit:Test for one test.

test_spec(Arg, Spec) :-
    term_to_atom(Spec, Arg).

run_specs([]) :-
    !,
    run_tests.
run_specs(Specs) :-
    run_tests(Specs).
