# Mutalog

Mutation testing for SWI-Prolog, modelled on [Stryker](https://stryker-mutator.io/).

Mutalog makes small changes to your Prolog code, such as a flipped comparison, a removed cut or a dropped clause, and checks that your plunit tests notice. A change the tests do not notice is a *surviving mutant*: a behaviour no test pins down.

> **Status: early draft.** This version reads sources and generates mutants (`mutalog list`). Running tests against mutants, the mutation score and reports come next; see [Roadmap](#roadmap).

## Requirements

SWI-Prolog 9.0 or later. Mutalog has no dependencies outside the SWI-Prolog distribution.

## Install

From a checkout:

```sh
git clone https://github.com/Looted/Mutalog.git
Mutalog/bin/mutalog list
```

As a pack, once published:

```prolog
?- pack_install(mutalog).
```

## Usage

Run from your project root:

```sh
mutalog list                                  # mutants for every file matched by `mutate`
mutalog list --mutate 'src/parser.pl'         # one file
mutalog list --operators compare,cut          # only some operators
mutalog list --format json                    # machine-readable
mutalog list --check                          # verify every mutant re-reads; exit 1 if not
```

Each mutant is printed with its id, the original source text and the replacement:

```
packages/core/src/logic_ir.pl:86:29:compare:1
    Arity =< 8  ->  Arity < 8
```

Ids have the form `file:line:column:operator:n`. They are stable while the code above the mutant does not move, and are what `ignore_mutants` takes.

## Configuration

Put a `mutalog.config.pl` in the project root. Every key is optional; names follow Stryker's where there is one.

```prolog
mutate(["src/**/*.pl"]).              % files to mutate (globs, ** for any depth)
ignore(["src/generated/**"]).         % files to skip
operators([arith, compare, unify, negate, cut,
           goal_true, goal_fail, clause_drop, literal]).
ignore_mutants(["src/eval.pl:42:9:compare:1"]).
```

Keys for running tests (`tests`, `load`, `concurrency`, `timeout_ms`, `timeout_factor`, `retries`, `stack_limit`, `thresholds`, `reporters`, `report_dir`) are accepted already and take effect once the runner lands.

## Mutation operators

| Operator | What it changes | Example |
| --- | --- | --- |
| `arith` | `+` and `-`, `*` and `/`, `//` `mod` `rem` to `*`, `min` and `max`, `<<` and `>>`; unary minus removed | `X is A + B` to `X is A - B` |
| `compare` | Arithmetic and standard-order comparisons, across the boundary and flipped | `X > 0` to `X >= 0`, `X =< 0` |
| `unify` | `=` and `\=`, `==` and `\==`, `=@=` and `\=@=` | `X == Y` to `X \== Y` |
| `negate` | Removes a `\+`; negates the condition of an if-then-else | `\+ member(X, L)` to `member(X, L)` |
| `cut` | Removes a cut; inserts one after the first goal of a non-last clause that has none | `p :- q, !, r.` to `p :- q, true, r.` |
| `goal_true` | Replaces a body goal with `true` | `p :- q, r.` to `p :- true, r.` |
| `goal_fail` | Replaces a body goal with `fail` | `p :- q, r.` to `p :- q, fail.` |
| `clause_drop` | Removes one clause of a multi-clause predicate | the second of `p(a). p(b).` |
| `literal` | Numbers (`0` to `1`, `N` to `N+1` and `-N`), strings (to and from `""`), `true` and `false`, `[]` to `[_]` | `limit(10)` to `limit(11)` |

Directives, DCG rules, CHR rules and anything inside `begin_tests`/`end_tests` are never mutated.

Operators are clauses of the multifile hooks `mutalog:operator/2` and `mutalog:mutate/4`, so a project can add its own; see `prolog/mutalog/operators.pl`.

## How it works

Mutalog reads each file with SWI-Prolog's own reader (`prolog_read_source_term/4`), so operators, quoting, dicts and strings are handled exactly as the compiler handles them, including operators imported from libraries. Each clause comes with its subterm positions, which is what lets a mutant be reported as a character range and a replacement, as Stryker does.

`--check` splices each replacement into the clause text, reads it back and compares it with the mutated clause the runner will execute. On [Kibi](https://github.com/Looted/kibi)'s Prolog core, 23 files, that is 29,908 mutants, all of which pass.

## Roadmap

1. **Read and generate** (this version): `mutalog list`.
2. **Dry run and worker**: run the plunit suite under coverage, apply one mutant in a child `swipl` and run the tests that cover it.
3. **Pool, scheduler, timeouts**: parallel workers, per-test selection, time limits from the dry run, retries for flaky tests.
4. **Reports and thresholds**: clear text, JSON in Stryker's `mutation-testing-report-schema`, HTML, `break` threshold exit code.
5. **Kibi dogfood**: a `test:mutation:prolog` lane in Kibi next to its Stryker lane.

## Development

```sh
swipl test/run.pl                              # tests
bin/mutalog list --mutate 'prolog/**/*.pl' --check   # Mutalog on itself
```
