# Changelog

All notable changes to Mutalog are listed here. Versions follow [Semantic Versioning](https://semver.org/).

## 0.3.0 (2026-10-29)

- Cut insertion is now its own operator, `cut_insert`; `cut` only removes cuts. An inserted cut after a goal with one solution can't change any answer, so a project can now drop `cut_insert` from `operators` and keep cut removal. Ids and `ignore_mutants` entries for inserted cuts change from `:cut:` to `:cut_insert:`.
- A `% mutalog-disable-next-line` comment suppresses the mutants on the line below it, optionally only for the operators it names (`% mutalog-disable-next-line cut_insert: reason`). Unlike an `ignore_mutants` id, it moves with the code.

## 0.2.0 (2026-10-29)

- A `mutate` glob that matches no files is now an error, like a `tests` glob that matches none. Both errors name the patterns and the directory they were resolved against.
- `thresholds(_, _, break(N))` with `N` above 0 now fails a run that scored no mutants, instead of passing it.
- `mutalog run --only` stops with an error when an id matches no mutant. `ignore_mutants` entries that match no mutant in a mutated file print a warning.
- Mutalog's own errors print as sentences instead of `Unknown error term`.
- New `root(Dir)` config key and `--root DIR` option set the project root, so a config file can live outside it. The README now says that `--config FILE` makes the file's directory the root.

## 0.1.2 (2026-10-29)

First release. Versions 0.1.0 and 0.1.1 were tagged but never published.

- Nine mutation operators: arithmetic, comparisons, unification, negation, cuts, goals replaced with `true` or `fail`, dropped clauses, and literals. `mutalog list` shows the mutants without running anything.
- A dry run records per-test coverage, so each mutant only runs the tests that reach it.
- A parallel worker pool with longest-first scheduling, soft and hard time limits, and crash retries.
- Reports: clear text, progress, a self-contained HTML page, and JSON in the mutation-testing-report-schema v2 format.
- Installs as a pack with `pack_install(mutalog)`. Run it with `swipl mutalog run` on SWI-Prolog 9.1.22+, or with the `-g mutalog:main` form on 9.0.
- Licensed BSD-2-Clause.
