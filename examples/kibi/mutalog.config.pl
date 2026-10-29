% Mutalog configuration for dogfooding on Looted/kibi.
% Copy to the root of a Kibi checkout, then run: mutalog list --check
%
% The first target is the logic IR interpreter: a 1,252-line module with a
% small, fast plunit file of its own. kb.plt (336 tests, RDF stores per
% test) comes after process pooling and timeouts are proven.

mutate(["packages/core/src/logic_ir.pl"]).
tests(["packages/core/tests/logic_ir.plt"]).
report_dir("reports/mutation/prolog").
