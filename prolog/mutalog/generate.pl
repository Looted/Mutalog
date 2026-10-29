:- module(mutalog_generate,
          [ source_mutants/4,        % +Source, +RelFile, +Ops, -Mutants
            verify_mutant/3,         % +Source, +Mutant, -Result
            term_text/4              % +Term, +VarNames, +Priority, -Text
          ]).

/** <module> Mutant generator

Walks every mutable clause together with its subterm positions, asks
each enabled operator for mutations at every site, and produces one
mutant per change. A mutant is a dict:

```
_{ id, file, operator, clause, clause_line, path,
   start, end, line, column, end_line, end_column,
   original, replacement, mutated_clause, var_names }
```

`start`-`end` is the character range replaced by `replacement`.
`mutated_clause` is the
whole clause after the change, or `none` for a dropped clause; it is
what a worker asserts in place of the original.
*/

:- use_module(library(lists)).
:- use_module(library(apply)).
:- use_module(library(pairs)).
:- use_module(reader).
:- use_module(operators).

%!  source_mutants(+Source, +RelFile, +Ops, -Mutants) is det.

source_mutants(Source, RelFile, Ops, Mutants) :-
    Source = source(_, Text, _, Clauses, OpModule),
    b_setval(mutalog_op_module, OpModule),
    predicate_counts(Clauses, Counts),
    findall(M,
            ( member(C, Clauses),
              C = clause(_, _, _, _, _, _, clause),
              clause_mutant(Source, Text, Counts, Ops, C, M)
            ),
            Mutants0),
    dedupe(Mutants0, Mutants1),
    assign_ids(Mutants1, Source, RelFile, Mutants).

%   ---------------------------------------------------------------
%   Predicate shape: how many clauses each predicate has, and which
%   one is last. This drives clause_drop and cut insertion.

clause_key(Term, Key) :-
    (   Term = (Head :- _)
    ->  true
    ;   Head = Term
    ),
    strip_module_term(Head, Plain),
    callable(Plain),
    functor(Plain, N, A),
    Key = N/A.

strip_module_term(T0, T) :-
    (   nonvar(T0), T0 = _:T1
    ->  strip_module_term(T1, T)
    ;   T = T0
    ).

predicate_counts(Clauses, Counts) :-
    findall(Key-I,
            ( member(clause(I, T, _, _, _, _, clause), Clauses),
              clause_key(T, Key)
            ),
            Pairs),
    keysort(Pairs, Sorted),
    group_pairs_by_key(Sorted, Counts).

clause_flags(Counts, I, Term, Flags) :-
    (   clause_key(Term, Key),
        memberchk(Key-Is, Counts),
        length(Is, N),
        N > 1
    ->  last(Is, Last),
        (   I == Last
        ->  Flags0 = [multi_clause, last_clause]
        ;   Flags0 = [multi_clause]
        )
    ;   Flags0 = []
    ),
    (   memberchk(multi_clause, Flags0),
        \+ memberchk(last_clause, Flags0),
        Term = (_ :- Body),
        \+ body_has_cut(Body)
    ->  Flags = [cut_insertable|Flags0]
    ;   Flags = Flags0
    ).

body_has_cut(B) :-
    var(B), !, fail.
body_has_cut(!) :- !.
body_has_cut((A,B)) :- !, ( body_has_cut(A) ; body_has_cut(B) ).
body_has_cut((A;B)) :- !, ( body_has_cut(A) ; body_has_cut(B) ).
body_has_cut((A->B)) :- !, ( body_has_cut(A) ; body_has_cut(B) ).
body_has_cut((A*->B)) :- !, ( body_has_cut(A) ; body_has_cut(B) ).

%   ---------------------------------------------------------------
%   Clause-level mutants

clause_mutant(Source, Text, Counts, Ops, C, M) :-
    C = clause(I, Term, Pos, VarNames, Start, End, clause),
    offset_line_col(Source, Start, ClauseLine, _),
    clause_flags(Counts, I, Term, ClauseFlags),
    (   memberchk(clause_drop, Ops),
        memberchk(multi_clause, ClauseFlags),
        Len is End - Start,
        sub_string(Text, Start, Len, _, Original),
        M0 = _{ operator: clause_drop, clause: I, path: none,
                start: Start, end: End,
                original: Original, replacement: "",
                mutated_clause: none, var_names: VarNames }
    ;   clause_site(Text, Term, Pos, ClauseFlags, Site),
        Site = site(Path, Ctx, Flags, Sub, SubPos, Pri),
        site_mutation(Ops, site(Ctx, Flags), Sub, Op-Mutated),
        arg(1, SubPos, From),
        arg(2, SubPos, To),
        Len is To - From,
        sub_string(Text, From, Len, _, Original),
        original_texts(Text, Sub, SubPos, Texts),
        term_text(Mutated, VarNames, Texts, Pri, Replacement0),
        pad_replacement(Text, From, To, Replacement0, Replacement),
        replace_at(Path, Term, Mutated, MutatedClause),
        M0 = _{ operator: Op, clause: I, path: Path,
                start: From, end: To,
                original: Original, replacement: Replacement,
                mutated_clause: MutatedClause, var_names: VarNames }
    ),
    position_fields(Source, M0.put(clause_line, ClauseLine), M).

%   original_texts(+Text, +Term, +Pos, -Pairs)
%
%   Pairs maps each compound subterm of the mutated site to its source
%   text, so that parts a mutation leaves alone are written exactly as
%   the author wrote them.

original_texts(Text, Term, Pos, Pairs) :-
    findall(Path-S, original_text(Text, Term, Pos, [], Path, S), PathTexts),
    maplist(path_subterm(Term), PathTexts, Pairs).

%   findall/3 copies its results, so collect paths and resolve them
%   against Term to keep the variables shared with the mutant.

path_subterm(Term, Path-S, Sub-S) :-
    subterm_at(Path, Term, Sub).

subterm_at([], T, T).
subterm_at([I|Is], T, Sub) :-
    arg(I, T, A),
    subterm_at(Is, A, Sub).

original_text(Text, Term, Pos0, Path0, Path, S) :-
    strip_parens(Pos0, 1200, Pos, _),
    (   compound(Term)
    ->  true
    ;   number(Term)
    ),
    (   arg(1, Pos, F), arg(2, Pos, To),
        integer(F), integer(To),
        L is To - F,
        sub_string(Text, F, L, _, S),
        Path = Path0
    ;   \+ dict_call(Term),
        data_child(Text, Term, Pos, Path0, A, AP, Path1, _),
        original_text(Text, A, AP, Path1, Path, S)
    ).

%   A replacement must not fuse with the characters around it into one
%   token: `f/1` with 1 changed to -1 must become `f/ -1`, not `f/-1`.

pad_replacement(Text, From, To, R0, R) :-
    (   From > 0,
        B is From - 1,
        sub_string(Text, B, 1, _, Before),
        sub_string(R0, 0, 1, _, First),
        fuses(Before, First)
    ->  string_concat(" ", R0, R1)
    ;   R1 = R0
    ),
    (   string_length(Text, Len),
        To < Len,
        sub_string(Text, To, 1, _, After),
        string_length(R0, RL), RL > 0,
        RB is RL - 1,
        sub_string(R0, RB, 1, _, Last),
        fuses(Last, After)
    ->  string_concat(R1, " ", R)
    ;   R = R1
    ).

fuses(A, B) :-
    symbol_char(A), symbol_char(B), !.
fuses(A, B) :-
    alnum_char(A), alnum_char(B).

symbol_char(C) :-
    sub_atom('#$&*+-./:<=>?@^~\\', _, 1, _, C), !.

alnum_char(C) :-
    string_code(1, C, Code),
    code_type(Code, csym).

position_fields(Source, M0, M) :-
    offset_line_col(Source, M0.start, L, Col),
    offset_line_col(Source, M0.end, EL, ECol),
    M = M0.put(_{line: L, column: Col, end_line: EL, end_column: ECol}).

%   Two operators can produce the same change at the same place, for
%   example a goal_fail and a compare on the same goal never do, but a
%   custom operator might. Keep the first.

dedupe([], []).
dedupe([M|Ms], [M|Rest]) :-
    exclude(same_mutant(M), Ms, Ms1),
    dedupe(Ms1, Rest).

same_mutant(A, B) :-
    A.clause == B.clause,
    A.start == B.start,
    A.end == B.end,
    A.replacement == B.replacement.

%   Ids are file:line:column:operator:n, readable in reports and stable
%   while the code above a clause does not move.

assign_ids(Ms0, _Source, RelFile, Ms) :-
    foldl(assign_id(RelFile), Ms0, Ms, [], _).

assign_id(RelFile, M0, M, Seen0, Seen) :-
    Key = M0.line-M0.column-M0.operator,
    aggregate_all(count, member(Key, Seen0), N0),
    N is N0 + 1,
    format(atom(Id), '~w:~w:~w:~w:~w',
           [RelFile, M0.line, M0.column, M0.operator, N]),
    M = M0.put(_{id: Id, file: RelFile}),
    Seen = [Key|Seen0].

%   ---------------------------------------------------------------
%   Sites. A site is site(Path, Context, Flags, Term, Pos, Priority):
%   Path is the argument path from the clause root, Pos the subterm
%   position with parentheses removed, Priority the highest operator
%   priority the text slot accepts without parentheses.

clause_site(Text, Term, Pos0, Flags, Site) :-
    strip_parens(Pos0, 1200, Pos, _),
    (   Term = (Head :- Body),
        Pos = term_position(_, _, _, _, [HP, BP])
    ->  (   head_site(Text, Head, HP, [1], Site)
        ;   slot_priority(Text, Term, Pos, 2, BPri),
            body_site(Text, Body, BP, [2], BPri, [first_goal|Flags], Site)
        )
    ;   Term = (_ :- _)
    ->  fail
    ;   head_site(Text, Term, Pos, [], Site)
    ).

head_site(Text, Head, Pos0, Path, Site) :-
    strip_parens(Pos0, 999, Pos, _),
    (   compound(Head), Head = _:H,
        Pos = term_position(_, _, _, _, [_, HP])
    ->  append(Path, [2], Path1),
        head_site(Text, H, HP, Path1, Site)
    ;   compound(Head),
        Pos = term_position(_, _, _, _, ArgPos)
    ->  nth1(I, ArgPos, AP),
        arg(I, Head, A),
        slot_priority(Text, Head, Pos, I, Pri),
        append(Path, [I], P1),
        data_site(Text, A, AP, P1, Pri, Site)
    ).

strip_parens(parentheses_term_position(_, _, Inner), _, Pos, Pri) :-
    !,
    strip_parens(Inner, 1200, Pos, Pri).
strip_parens(Pos, Pri, Pos, Pri).

body_site(Text, G, Pos0, Path, Pri0, Flags, Site) :-
    strip_parens(Pos0, Pri0, Pos, Pri),
    (   var(G)
    ->  fail
    ;   G = (A, B),
        Pos = term_position(_, _, _, _, [PA, PB])
    ->  slot_priority(Text, G, Pos, 1, PriA),
        slot_priority(Text, G, Pos, 2, PriB),
        append(Path, [1], PathA),
        append(Path, [2], PathB),
        (   body_site(Text, A, PA, PathA, PriA, Flags, Site)
        ;   exclude(==(first_goal), Flags, FlagsB),
            body_site(Text, B, PB, PathB, PriB, FlagsB, Site)
        )
    ;   G = (IT ; E),
        Pos = term_position(_, _, _, _, [ITP0, EP]),
        strip_parens(ITP0, 1099, ITP, _),
        nonvar(IT), ( IT = (C -> T) ; IT = (C *-> T) ),
        ITP = term_position(_, _, _, _, [CP, TP])
    ->  rest_flags(Flags, Fs),
        slot_priority(Text, IT, ITP, 1, CPri),
        slot_priority(Text, IT, ITP, 2, TPri),
        slot_priority(Text, G, Pos, 2, EPri),
        append(Path, [1,1], CPath),
        append(Path, [1,2], TPath),
        append(Path, [2], EPath),
        (   cond_site(C, CP, CPath, CPri, Fs, Site)
        ;   body_site(Text, C, CP, CPath, CPri, Fs, Site)
        ;   body_site(Text, T, TP, TPath, TPri, Fs, Site)
        ;   body_site(Text, E, EP, EPath, EPri, Fs, Site)
        )
    ;   ( G = (C -> T) ; G = (C *-> T) ),
        Pos = term_position(_, _, _, _, [CP, TP])
    ->  rest_flags(Flags, Fs),
        slot_priority(Text, G, Pos, 1, CPri),
        slot_priority(Text, G, Pos, 2, TPri),
        append(Path, [1], CPath),
        append(Path, [2], TPath),
        (   cond_site(C, CP, CPath, CPri, Fs, Site)
        ;   body_site(Text, C, CP, CPath, CPri, Fs, Site)
        ;   body_site(Text, T, TP, TPath, TPri, Fs, Site)
        )
    ;   G = (A ; B),
        Pos = term_position(_, _, _, _, [PA, PB])
    ->  rest_flags(Flags, Fs),
        slot_priority(Text, G, Pos, 1, PriA),
        slot_priority(Text, G, Pos, 2, PriB),
        append(Path, [1], PathA),
        append(Path, [2], PathB),
        (   body_site(Text, A, PA, PathA, PriA, Fs, Site)
        ;   body_site(Text, B, PB, PathB, PriB, Fs, Site)
        )
    ;   G = (_:G1),
        Pos = term_position(_, _, _, _, [_, GP])
    ->  append(Path, [2], Path1),
        slot_priority(Text, G, Pos, 2, Pri1),
        body_site(Text, G1, GP, Path1, Pri1, Flags, Site)
    ;   goal_site(Text, G, Pos, Path, Pri, Flags, Site)
    ).

rest_flags(Flags0, Flags) :-
    exclude(==(first_goal), Flags0, Flags).

cond_site(C, Pos0, Path, Pri0, Flags, Site) :-
    strip_parens(Pos0, Pri0, Pos, Pri),
    nonvar(C),
    Site = site(Path, cond, Flags, C, Pos, Pri).

goal_site(Text, G, Pos, Path, Pri, Flags, Site) :-
    (   Site = site(Path, goal, Flags, G, Pos, Pri)
    ;   compound(G),
        Pos = term_position(_, _, _, _, ArgPos),
        rest_flags(Flags, Flags1),
        nth1(I, ArgPos, AP),
        arg(I, G, A),
        slot_priority(Text, G, Pos, I, PriI),
        append(Path, [I], PathI),
        arg_kind(G, I, Kind),
        (   Kind == goal
        ->  body_site(Text, A, AP, PathI, PriI, Flags1, Site)
        ;   Kind == arith
        ->  arith_site(Text, A, AP, PathI, PriI, Site)
        ;   data_site(Text, A, AP, PathI, PriI, Site)
        )
    ).

%!  arg_kind(+Goal, +I, -Kind) is det.
%
%   Whether argument I of Goal is a goal, an arithmetic expression or
%   plain data.

arg_kind(G, I, Kind) :-
    functor(G, Name, Arity),
    (   meta_goal_arg(Name, Arity, I)
    ->  Kind = goal
    ;   arith_goal(Name, Arity, I)
    ->  Kind = arith
    ;   Kind = data
    ).

meta_goal_arg(\+, 1, 1).
meta_goal_arg(call, _, 1).
meta_goal_arg(once, 1, 1).
meta_goal_arg(ignore, 1, 1).
meta_goal_arg(forall, 2, _).
meta_goal_arg(findall, 3, 2).
meta_goal_arg(findall, 4, 2).
meta_goal_arg(aggregate_all, 3, 2).
meta_goal_arg(aggregate_all, 4, 3).
meta_goal_arg(catch, 3, 1).
meta_goal_arg(catch, 3, 3).
meta_goal_arg(setup_call_cleanup, 3, _).
meta_goal_arg(call_cleanup, 2, _).
meta_goal_arg(with_output_to, 2, 2).
meta_goal_arg(limit, 2, 2).
meta_goal_arg(offset, 2, 2).
meta_goal_arg(order_by, 2, 2).
meta_goal_arg(distinct, 1, 1).
meta_goal_arg(distinct, 2, 2).
meta_goal_arg(call_with_time_limit, 2, 2).
meta_goal_arg(call_with_depth_limit, 3, 1).
meta_goal_arg(call_with_inference_limit, 3, 1).
meta_goal_arg(snapshot, 1, 1).
meta_goal_arg(transaction, 1, 1).

arith_goal(is, 2, 2).
arith_goal(Op, 2, _) :-
    memberchk(Op, [<, >, =<, >=, =:=, =\=]).

arith_site(Text, T, Pos0, Path, Pri0, Site) :-
    strip_parens(Pos0, Pri0, Pos, Pri),
    (   Site = site(Path, arith, [], T, Pos, Pri)
    ;   compound(T),
        \+ dict_call(T),
        Pos = term_position(_, _, _, _, ArgPos),
        nth1(I, ArgPos, AP),
        arg(I, T, A),
        slot_priority(Text, T, Pos, I, PriI),
        append(Path, [I], PathI),
        arith_site(Text, A, AP, PathI, PriI, Site)
    ).

data_site(Text, T, Pos0, Path, Pri0, Site) :-
    strip_parens(Pos0, Pri0, Pos, Pri),
    (   Site = site(Path, data, [], T, Pos, Pri)
    ;   compound(T),
        \+ dict_call(T),
        data_child(Text, T, Pos, Path, A, AP, PathI, PriI),
        data_site(Text, A, AP, PathI, PriI, Site)
    ).

data_child(Text, T, term_position(F,To,FF,FT,ArgPos), Path, A, AP, PathI, PriI) :-
    nth1(I, ArgPos, AP),
    arg(I, T, A),
    slot_priority(Text, T, term_position(F,To,FF,FT,ArgPos), I, PriI),
    append(Path, [I], PathI).
data_child(_Text, T, list_position(_, _, Elems, TailPos), Path, A, AP, PathI, 999) :-
    (   nth0(N, Elems, AP),
        list_path(N, Path, P0),
        append(P0, [1], PathI),
        list_nth(N, T, Cell),
        arg(1, Cell, A)
    ;   TailPos \== none,
        AP = TailPos,
        length(Elems, Len),
        list_path(Len, Path, PathI),
        list_skip(Len, T, A)
    ).
data_child(_Text, {X}, brace_term_position(_, _, AP), Path, X, AP, PathI, 1200) :-
    append(Path, [1], PathI).

list_path(0, Path, Path) :- !.
list_path(N, Path0, Path) :-
    append(Path0, [2], Path1),
    N1 is N - 1,
    list_path(N1, Path1, Path).

list_nth(0, Cell, Cell) :- !.
list_nth(N, [_|T], Cell) :-
    N1 is N - 1,
    list_nth(N1, T, Cell).

list_skip(0, T, T) :- !.
list_skip(N, [_|T0], T) :-
    N1 is N - 1,
    list_skip(N1, T0, T).

dict_call(T) :-
    compound(T),
    compound_name_arity(T, '.', 2).

%!  slot_priority(+Text, +Parent, +ParentPos, +I, -Priority) is det.
%
%   The highest priority a term may have in argument I of Parent as it
%   is written in the source: 999 for canonical f(...) arguments, and
%   for operator arguments the priority the operator's type allows.

slot_priority(Text, Parent, term_position(_, _, FF, FT, ArgPos), I, Pri) :-
    compound_name_arity(Parent, Name, Arity),
    (   canonical_form(Text, FT)
    ->  Pri = 999
    ;   Arity =:= 2,
        ArgPos = [A1|_],
        arg(2, A1, A1End),
        FF >= A1End,
        infix_op(Name, P, Type)
    ->  infix_slot(Type, P, I, Pri)
    ;   Arity =:= 1,
        ArgPos = [A1],
        arg(1, A1, A1Start),
        FF < A1Start,
        prefix_op(Name, P, Type)
    ->  ( Type == fy -> Pri = P ; Pri is P - 1 )
    ;   Arity =:= 1,
        postfix_op(Name, P, Type)
    ->  ( Type == yf -> Pri = P ; Pri is P - 1 )
    ;   Pri = 999
    ),
    !.
slot_priority(_, _, _, _, 999).

canonical_form(Text, FT) :-
    string_length(Text, Len),
    FT < Len,
    sub_string(Text, FT, 1, _, "(").

%   Operators are looked up in the op module of the source being
%   processed, set by source_mutants/4 and verify_mutant/3.

op_module(M) :-
    (   nb_current(mutalog_op_module, M0),
        atom(M0)
    ->  M = M0
    ;   M = user
    ).

infix_op(Name, P, Type) :-
    op_module(M),
    current_op(P, Type, M:Name),
    memberchk(Type, [xfx, xfy, yfx]),
    !.
prefix_op(Name, P, Type) :-
    op_module(M),
    current_op(P, Type, M:Name),
    memberchk(Type, [fy, fx]),
    !.
postfix_op(Name, P, Type) :-
    op_module(M),
    current_op(P, Type, M:Name),
    memberchk(Type, [xf, yf]),
    !.

infix_slot(xfx, P, _, Pri) :- Pri is P - 1.
infix_slot(xfy, P, 1, Pri) :- Pri is P - 1.
infix_slot(xfy, P, 2, P).
infix_slot(yfx, P, 1, P).
infix_slot(yfx, P, 2, Pri) :- Pri is P - 1.

%!  replace_at(+Path, +Term, +New, -Result) is det.

replace_at([], _, New, New).
replace_at([I|Is], Term, New, Result) :-
    compound_name_arguments(Term, Name, Args0),
    nth1(I, Args0, A0, Rest),
    replace_at(Is, A0, New, A),
    nth1(I, Args, A, Rest),
    compound_name_arguments(Result, Name, Args).

%!  term_text(+Term, +VarNames, +Priority, -Text) is det.
%
%   Write Term as source text using the clause's own variable names.
%   Variables without a name are written as `_`.

term_text(Term, VarNames, Pri, Text) :-
    term_text(Term, VarNames, [], Pri, Text).

%   Texts pairs subterms with their original source text; such subterms
%   are written as the author wrote them (see original_texts/4).

term_text(Term, VarNames, Texts, Pri, Text) :-
    copy_term(Term-VarNames-Texts, Copy-VN-TextsCopy),
    maplist(bind_name, VN),
    term_variables(Copy-TextsCopy, Fresh),
    maplist(=('$VAR'('_')), Fresh),
    b_setval(mutalog_texts, TextsCopy),
    with_output_to(string(Text), pp(Copy, Pri)),
    b_setval(mutalog_texts, []).

%   A small pretty-printer: operators get the spacing people write
%   (`X - 1`, `\+ G`, `A, B`), everything else is written by
%   write_term/2. verify_mutant/3 re-reads the result, so a mistake
%   here shows up as a failed check rather than a wrong mutant.

pp(T, Pri) :-
    (   compound(T)
    ->  true
    ;   number(T)
    ),
    nb_current(mutalog_texts, Texts),
    member(O-S, Texts),
    O == T,
    !,
    (   compound(T),
        written_priority(T, P),
        P > Pri
    ->  format('(~w)', [S])
    ;   write(S)
    ).
pp(T, Pri) :-
    compound(T),
    \+ T = '$VAR'(_),
    compound_name_arguments(T, Name, [L, R]),
    spaced_infix(Name),
    infix_op(Name, P, Type),
    !,
    (   P > Pri
    ->  write('('), pp(T, 1200), write(')')
    ;   infix_slot(Type, P, 1, LP),
        infix_slot(Type, P, 2, RP),
        pp(L, LP),
        (   Name == (',')
        ->  write(', ')
        ;   format(' ~q ', [Name])
        ),
        pp(R, RP)
    ).
pp(T, Pri) :-
    compound(T),
    T = \+(G),
    prefix_op(\+, P, Type),
    !,
    (   P > Pri
    ->  write('('), pp(T, 1200), write(')')
    ;   ( Type == fy -> AP = P ; AP is P - 1 ),
        write('\\+ '),
        pp(G, AP)
    ).
pp(T, _) :-
    compound(T),
    \+ T = '$VAR'(_),
    \+ is_list(T),
    \+ T = [_|_],
    \+ T = {_},
    \+ dict_call(T),
    \+ is_dict(T),
    compound_name_arguments(T, Name, Args),
    Args \== [],
    op_module(M),
    \+ current_op(_, _, M:Name),
    !,
    format('~q(', [Name]),
    pp_args(Args),
    write(')').
pp(T, Pri) :-
    op_module(M),
    write_term(T, [ module(M),
                    quoted(true),
                    numbervars(true),
                    priority(Pri),
                    spacing(next_argument),
                    portray(false)
                  ]).

written_priority(T, P) :-
    compound_name_arity(T, Name, Arity),
    (   Arity =:= 2
    ->  infix_op(Name, P, _)
    ;   Arity =:= 1
    ->  (   prefix_op(Name, P, _)
        ->  true
        ;   postfix_op(Name, P, _)
        )
    ).

pp_args([A]) :-
    !,
    pp(A, 999).
pp_args([A|As]) :-
    pp(A, 999),
    write(', '),
    pp_args(As).

spaced_infix(Name) :-
    \+ memberchk(Name, [':', '.', '^', '**', '|', '$']).

bind_name(Name=Var) :-
    (   var(Var)
    ->  Var = '$VAR'(Name)
    ;   true
    ).

%!  verify_mutant(+Source, +Mutant, -Result) is det.
%
%   Splice the replacement into the clause text, read it back, and
%   check it reads as the mutated clause. Result is `ok` or
%   `error(Reason)`. This is the generator's own consistency check:
%   every mutant the report shows as text must be the mutant a worker
%   runs.

verify_mutant(_, M, ok) :-
    M.mutated_clause == none,
    !.
verify_mutant(Source, M, Result) :-
    Source = source(_, Text, _, Clauses, OpModule),
    b_setval(mutalog_op_module, OpModule),
    memberchk(clause(M.clause, _, _, _, CStart, CEnd, _), Clauses),
    BeforeLen is M.start - CStart,
    sub_string(Text, CStart, BeforeLen, _, Before),
    AfterLen is CEnd - M.end,
    sub_string(Text, M.end, AfterLen, _, After),
    string_concat(Before, M.replacement, S1),
    string_concat(S1, After, Spliced),
    (   catch(term_string(Read, Spliced, [module(OpModule)]), E, true)
    ->  (   nonvar(E)
        ->  Result = error(syntax(Spliced))
        ;   Read =@= M.mutated_clause
        ->  Result = ok
        ;   Result = error(mismatch(Spliced))
        )
    ;   Result = error(unreadable(Spliced))
    ).
