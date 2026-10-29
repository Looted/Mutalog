% Run the Mutalog test suite: swipl test/run.pl
:- initialization(run_all, main).

:- use_module(library(plunit)).
:- set_prolog_flag(encoding, utf8).
:- load_files('test_mutalog.plt', []).

run_all :-
    (   run_tests
    ->  halt(0)
    ;   halt(1)
    ).
