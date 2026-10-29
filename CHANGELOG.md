# Changelog

All notable changes to Mutalog are listed here. Versions follow [Semantic Versioning](https://semver.org/).

## 0.1.2 (2026-10-29)

First release. Versions 0.1.0 and 0.1.1 were tagged but never published.

- Nine mutation operators: arithmetic, comparisons, unification, negation, cuts, goals replaced with `true` or `fail`, dropped clauses, and literals. `mutalog list` shows the mutants without running anything.
- A dry run records per-test coverage, so each mutant only runs the tests that reach it.
- A parallel worker pool with longest-first scheduling, soft and hard time limits, and crash retries.
- Reports: clear text, progress, a self-contained HTML page, and JSON in the mutation-testing-report-schema v2 format.
- Installs as a pack with `pack_install(mutalog)`. Run it with `swipl mutalog run` on SWI-Prolog 9.1.22+, or with the `-g mutalog:main` form on 9.0.
- Licensed BSD-2-Clause.
