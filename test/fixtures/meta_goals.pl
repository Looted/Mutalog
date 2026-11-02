:- module(meta_goals, [p/1, q/1]).

%   One goal inside each meta-predicate argument Mutalog treats as a goal.

p(X) :-
    \+ a(X),
    call(a, X),
    once(a(X)),
    ignore(a(X)),
    forall(a(X), a(X)),
    findall(X, a(X), _),
    findall(X, a(X), _, []),
    aggregate_all(count, a(X), _),
    aggregate_all(count, X, a(X), _),
    catch(a(X), _, a(X)),
    setup_call_cleanup(a(X), a(X), a(X)),
    call_cleanup(a(X), a(X)),
    with_output_to(string(_), a(X)),
    limit(1, a(X)),
    offset(1, a(X)),
    order_by([asc(X)], a(X)),
    distinct(a(X)),
    distinct(X, a(X)),
    call_with_time_limit(1, a(X)),
    call_with_depth_limit(a(X), 10, _),
    call_with_inference_limit(a(X), 100, _),
    snapshot(a(X)),
    transaction(a(X)).

%   A soft cut is not a cut: the first clause can take an inserted one.

q(X) :- a(X), ( a(X) *-> true ; true ).
q(_).

a(1).
