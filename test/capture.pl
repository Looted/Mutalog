:- module(capture,
          [ stderr_text/2,          % :Goal, -Text
            lines_text/2            % +Lines, -Text
          ]).

/** <module> Output capture for the tests

Kept out of the test files: it calls a goal held in a variable and
prints message lines, which a static reading of the test files cannot
follow.
*/

:- meta_predicate stderr_text(0, -).

%!  stderr_text(:Goal, -Text) is semidet.
%
%   Text is what Goal writes to user_error, which it does not print.

stderr_text(Goal, Text) :-
    stream_property(Err, alias(user_error)),
    with_output_to(string(Text),
                   ( current_output(Out),
                     setup_call_cleanup(set_stream(Out, alias(user_error)),
                                        Goal,
                                        set_stream(Err, alias(user_error))) )).

%!  lines_text(+Lines, -Text) is det.
%
%   Text is how print_message/2 would show the message lines Lines.

lines_text(Lines, Text) :-
    with_output_to(string(Text), print_message_lines(current_output, '', Lines)).
