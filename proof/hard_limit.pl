/*  Proof that the controller's hard limit is 10 seconds after the
    worker's time limit.

    Kibi reads hard_limit_margin/1 from prolog/mutalog/run.pl itself;
    this run reads the same constant and certifies the claim about it.
*/

:- use_module('../prolog/mutalog/run').
:- use_module(kibi_certificate).
:- initialization(main, main).

main :-
    mutalog_run:hard_limit_margin(Seconds),
    kibi_arithmetic_certificate('TEST-cert-hard-limit-is-ten-seconds-late',
                                margin_seconds, Seconds, eq-10, Certificate),
    kibi_write_certificate(Certificate).
