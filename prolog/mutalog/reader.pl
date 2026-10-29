:- module(mutalog_reader,
          [ read_source/2,           % +File, -Source
            source_text/2,           % +Source, -Text
            source_clauses/2,        % +Source, -Clauses
            source_op_module/2,      % +Source, -Module
            offset_line_col/4        % +Source, +Offset, -Line, -Col
          ]).

/** <module> Clause reader

Reads a Prolog source file with the engine's own reader, so operators,
quoting, `0'c` codes, strings, dicts and comments are handled exactly as
the compiler handles them. Each term comes back with its subterm
positions, which is what lets the generator report a mutant as a
character range and replacement text.

A source is represented as

```
source(File, Text, LineStarts, Clauses, OpModule)
```

OpModule is a private module holding the operators that were in force
while the file was read, including those imported from libraries such
as `library(semweb/rdf11)`. Writing and re-reading mutants happens in
that module so their text means what it means in the file.

and each element of Clauses is

```
clause(Index, Term, Pos, VarNames, Start, End, Kind)
```

where Start-End is the character range of the term including its full
stop, and Kind is `clause` for a mutable clause or `skip(Reason)` for a
directive, test block, CHR rule, DCG rule or similar.
*/

:- use_module(library(prolog_source)).
:- use_module(library(readutil)).
:- use_module(library(lists)).
:- use_module(library(apply)).

%!  read_source(+File, -Source) is det.

read_source(File, source(File, Text, LineStarts, Clauses, OpModule)) :-
    read_file_to_string(File, Text, [encoding(utf8)]),
    line_starts(Text, LineStarts),
    setup_call_cleanup(
        ( prolog_open_source(File, In),
          set_stream(In, encoding(utf8))
        ),
        ( read_clauses(In, Text, 0, outside, Clauses),
          snapshot_ops(OpModule)
        ),
        prolog_close_source(In)).

source_text(source(_, Text, _, _, _), Text).
source_clauses(source(_, _, _, Clauses, _), Clauses).
source_op_module(source(_, _, _, _, M), M).

%   Copy the operators visible in the source module that differ from
%   those in `user` into a fresh module.

snapshot_ops(OpModule) :-
    '$current_source_module'(SM),
    gensym(mutalog_ops_, OpModule),
    forall(( current_op(P, T, SM:N),
             \+ current_op(P, T, user:N)
           ),
           op(P, T, OpModule:N)),
    forall(( current_op(_, T, user:N),
             op_class(T, Class),
             \+ ( current_op(_, T2, SM:N), op_class(T2, Class) )
           ),
           op(0, T, OpModule:N)).

op_class(T, infix)   :- memberchk(T, [xfx, xfy, yfx]).
op_class(T, prefix)  :- memberchk(T, [fy, fx]).
op_class(T, postfix) :- memberchk(T, [xf, yf]).

read_clauses(In, Text, I0, State0, Clauses) :-
    prolog_read_source_term(In, Term0, _Expanded,
                            [ subterm_positions(Pos),
                              variable_names(VarNames0),
                              syntax_errors(error)
                            ]),
    % Term expansion (for example by library(yall)) can leave attributes
    % on the variables it shares with the raw term. Drop them so mutants
    % compare as plain terms.
    copy_term_nat(Term0-VarNames0, Term-VarNames),
    (   Term == end_of_file
    ->  Clauses = []
    ;   term_range(Pos, Text, Start, End),
        classify(Term, State0, State, Kind),
        I is I0 + 1,
        Clauses = [clause(I, Term, Pos, VarNames, Start, End, Kind)|Rest],
        read_clauses(In, Text, I, State, Rest)
    ).

%   Terms between begin_tests and end_tests are test code and are never
%   mutated.

classify(Term, State0, State, Kind) :-
    (   directive(Term, Goal)
    ->  Kind = skip(directive),
        test_block_state(Goal, State0, State)
    ;   State0 = inside_tests
    ->  State = State0,
        Kind = skip(test_block)
    ;   State = State0,
        clause_kind(Term, Kind)
    ).

directive((:- Goal), Goal).
directive((?- Goal), Goal).

test_block_state(begin_tests(_), _, inside_tests) :- !.
test_block_state(begin_tests(_, _), _, inside_tests) :- !.
test_block_state(end_tests(_), _, outside) :- !.
test_block_state(_, State, State).

clause_kind(Term, Kind) :-
    (   var(Term)
    ->  Kind = skip(variable)
    ;   Term = (_ --> _)
    ->  Kind = skip(dcg)
    ;   chr_rule(Term)
    ->  Kind = skip(chr)
    ;   Kind = clause
    ).

chr_rule(T) :-
    compound(T),
    compound_name_arity(T, Name, 2),
    memberchk(Name, ['@', '==>', '<=>', pragma]).

%   The reader's position ends before the full stop. Extend the range
%   over layout to include the '.' so a dropped clause leaves no stray
%   full stop behind.

term_range(Pos, Text, Start, End) :-
    arg(1, Pos, Start),
    arg(2, Pos, TermEnd),
    (   full_stop_after(Text, TermEnd, Dot)
    ->  End is Dot + 1
    ;   End = TermEnd
    ).

full_stop_after(Text, Offset, Dot) :-
    string_length(Text, Len),
    Offset < Len,
    sub_string(Text, Offset, 1, _, C),
    (   C == "."
    ->  Dot = Offset
    ;   memberchk(C, [" ", "\t", "\r", "\n"])
    ->  Next is Offset + 1,
        full_stop_after(Text, Next, Dot)
    ).

line_starts(Text, [0|Starts]) :-
    string_codes(Text, Codes),
    findall(S, ( nth0(I, Codes, 0'\n), S is I + 1 ), Starts).

%!  offset_line_col(+Source, +Offset, -Line, -Col) is det.
%
%   One-based line and column of a character offset.

offset_line_col(source(_, _, Starts, _, _), Offset, Line, Col) :-
    last_start(Starts, Offset, 0, 0, Line0, LineStart),
    Line is Line0 + 1,
    Col is Offset - LineStart + 1.

last_start([S|Ss], Offset, N, _, Line, LineStart) :-
    S =< Offset,
    !,
    N1 is N + 1,
    last_start(Ss, Offset, N1, S, Line, LineStart).
last_start(_, _, N, Prev, Line, Prev) :-
    Line is N - 1.
