:- use_module('../src/calc').

:- begin_tests(calc).

test(sign_positive) :- sign(5, S), S == positive.
test(sign_zero)     :- sign(0, S), S == zero.
test(sign_negative) :- sign(-3, S), S == negative.
test(sum)           :- sum([1, 2, 3], S), S =:= 6.
test(sum_empty)     :- sum([], S), S =:= 0.
test(countdown)     :- countdown(3).
% Weak on purpose: only the first clause of max2/3 is exercised.
test(max_first)     :- max2(3, 1, M), M == 3.

:- end_tests(calc).
