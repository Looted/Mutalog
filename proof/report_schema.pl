/*  Proof that mutation.json follows version 2 of the mutation-testing
    report schema.

    Kibi reads report_schema_version/1 from prolog/mutalog/report.pl
    itself; report_dict/2 puts that constant in the report.
*/

:- use_module('../prolog/mutalog/report').
:- use_module(kibi_certificate).
:- initialization(main, main).

main :-
    mutalog_report:report_schema_version(Version),
    kibi_pattern_certificate('TEST-cert-report-schema-version-2',
                             'SYM-report-schema-version', Version, Certificate),
    kibi_write_certificate(Certificate).
