:- module(kibi_certificate,
          [ kibi_exhaustive_certificate/5,  % +TestId, +SymbolId, +Members, :Check, -Certificate
            kibi_write_certificate/1        % +Certificate
          ]).

/** <module> Kibi code certificates

The exhaustive part of the `kibi_certificate` module from the kibi-usage
skill: a proof script checks every member of a domain and leaves a
`kibi.code-certificate.v1` certificate where `kibi prove` reads it.
*/

:- use_module(library(http/json)).
:- use_module(library(apply)).
:- use_module(library(lists)).

:- meta_predicate
    kibi_exhaustive_certificate(+, +, +, 1, -).

% Members as Kibi reads them: atoms and strings as text, numbers as written,
% other terms quoted.
kibi_text(Value, Text) :- string(Value), !, Text = Value.
kibi_text(Value, Text) :- atom(Value), !, atom_string(Value, Text).
kibi_text(Value, Text) :- number(Value), !, number_string(Value, Text).
kibi_text(Value, Text) :- format(string(Text), "~q", [Value]).

%!  kibi_exhaustive_certificate(+TestId, +SymbolId, +Members, :Check, -Certificate)
%
%   Run Check on every member of the domain and record each outcome. Read
%   Members from the code (findall over the domain predicate), never list
%   them by hand: Kibi re-reads the predicate and rejects a different set.
kibi_exhaustive_certificate(TestId, SymbolId, Members, Check, Certificate) :-
    maplist(kibi_text, Members, Texts),
    maplist(exhaustive_result(Check), Members, Texts, Results),
    Certificate = _{version: "kibi.code-certificate.v1", kind: "exhaustive",
                    test_id: TestId,
                    domain: _{symbol_id: SymbolId, members: Texts},
                    results: Results}.

exhaustive_result(Check, Member, Text, Result) :-
    catch(( call(Check, Member)
          -> Result = _{member: Text, outcome: "passed"}
          ;  Result = _{member: Text, outcome: "failed", message: "the check failed"}
          ),
          Error,
          ( message_to_text(Error, Message),
            Result = _{member: Text, outcome: "failed", message: Message} )).

%!  kibi_write_certificate(+Certificate)
%
%   Leave the certificate where kibi prove reads it (the directory in
%   KIBI_PROOF_CERTIFICATES). Does nothing outside a kibi prove run.
kibi_write_certificate(Certificate) :-
    (   getenv('KIBI_PROOF_CERTIFICATES', Directory), Directory \== ''
    ->  make_directory_path(Directory),
        get_dict(test_id, Certificate, TestId),
        format(atom(Name), "~w.json", [TestId]),
        directory_file_path(Directory, Name, File),
        setup_call_cleanup(open(File, write, Out, [encoding(utf8)]),
                           json_write_dict(Out, Certificate, [width(0)]),
                           close(Out))
    ;   true
    ).

message_to_text(Error, Text) :-
    format(string(Text), "~q", [Error]).
