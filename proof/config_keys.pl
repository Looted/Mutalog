/*  Proof that every configuration key is optional.

    Kibi loads prolog/mutalog/config.pl itself and reads the keys from
    default_setting/2; this run checks each one: with no config file in
    the project, load_config/3 still gives the key a value.
*/

:- use_module('../prolog/mutalog/config').
:- use_module(kibi_certificate).
:- use_module(library(filesex)).
:- initialization(main, main).

main :-
    findall(Key, default_setting(Key, _), Keys0),
    list_to_set(Keys0, Keys),
    tmp_file(mutalog_empty_project, Root),
    make_directory(Root),
    load_config(Root, [], Config),
    kibi_exhaustive_certificate('TEST-cert-every-config-key-is-optional',
                                'SYM-config-default-setting', Keys,
                                has_value(Config), Certificate),
    delete_directory(Root),
    get_dict(results, Certificate, Results),
    forall(member(Result, Results), get_dict(outcome, Result, "passed")),
    kibi_write_certificate(Certificate).

has_value(Config, Key) :-
    member(Term, Config),
    functor(Term, Key, _),
    !.
