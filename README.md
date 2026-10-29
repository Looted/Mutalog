# Mutalog

Mutation testing for SWI-Prolog.

Mutalog makes small changes to your Prolog code, such as a flipped comparison, a removed cut or a dropped clause, and checks that your plunit tests notice. A change the tests do not notice is a *surviving mutant*: a behaviour no test pins down.

> **Status: 0.1.2, first release.** Mutalog generates mutants, runs your plunit tests against each one on parallel workers, and reports a mutation score in the terminal, as HTML and as JSON. See [Roadmap](#roadmap) for what is in it.

## Requirements

SWI-Prolog 9.0 or later. Mutalog has no dependencies outside the SWI-Prolog distribution.

## Install

As a pack:

```prolog
?- pack_install(mutalog).
```

Then, from your project root:

```sh
swipl mutalog run                     # SWI-Prolog 9.1.22 or later
swipl -g "use_module(library(mutalog))" -g mutalog:main -t 'halt(2)' -- run   # any 9.x
```

Or from a checkout, with no install:

```sh
git clone https://github.com/Looted/Mutalog.git
Mutalog/bin/mutalog run
```

The examples below use `mutalog` for whichever of these you use.

## Usage

Run from your project root:

```sh
mutalog run                                   # mutate, run the tests, report the score
mutalog run --only 'src/eval.pl:42:9:compare:1'   # re-run chosen mutants while fixing tests
mutalog dry-run                               # run the suite once: per-test times and coverage
mutalog list                                  # print the mutants without running anything
mutalog list --format json --check            # machine-readable; verify every mutant re-reads
```

Every command takes `--mutate GLOB` and `--tests GLOB` (both repeatable), `--operators a,b`, `--timeout-ms N` and `--config FILE`. `run` also takes `-c N` or `--concurrency N` for the number of workers, `--reporters a,b` to pick the outputs, and `--verbose` to show the project's own output.

`mutalog run` prints each mutant as it finishes, then the survivors with their source change, and a summary:

```
Survived (12):
  src/calc.pl:16:18:compare:1
      X >= Y  ->  X > Y
      covered by 1 test(s)

File                                       Score  Killed   Surv. Timeout No cov.  Errors
src/calc.pl                                67.3%      35      12       2       6       0

Mutation score: 67.3% (covered code: 75.5%)
```

It also writes two report files to `reports/mutation/`:

- `mutation.html` is one self-contained page with no network access. It shows the score per file and the source with every mutant marked. You can filter by status and click a mutant to see the change and the tests that cover it.
- `mutation.json` follows the open `mutation-testing-report-schema` format, schema version 2, so other tools that read the format can use it.

A survivor is a change no test notices: add a test that pins the behaviour down, or list the mutant in `ignore_mutants` if the change is equivalent. Ids have the form `file:line:column:operator:n`. They stay stable as long as the code above the mutant doesn't move.

### Statuses and score

| Status | Meaning |
| --- | --- |
| killed | A test that covers the mutated clause failed |
| survived | Every covering test passed |
| timeout | The tests ran past the time limit, usually because the mutant loops |
| no coverage | No test entered the mutated clause, so nothing was run |
| compile error | The mutated file did not load |
| runtime error | The worker process crashed, on every retry |

The mutation score is the share of mutants detected, counting killed and timeout, out of killed, timeout, survived and no coverage. The covered-code score leaves out no coverage. `mutalog run` exits with 1 when the score is below `thresholds(_, _, break(N))`.

## Configuration

Put a `mutalog.config.pl` in the project root. Every key is optional.

```prolog
mutate(["src/**/*.pl"]).              % files to mutate (globs, ** for any depth)
ignore(["src/generated/**"]).         % files to skip
tests(["test/**/*.plt"]).             % plunit files to load and run
load(["load.pl"]).                    % files to load before the tests, if they need it
operators([arith, compare, unify, negate, cut,
           goal_true, goal_fail, clause_drop, literal]).
ignore_mutants(["src/eval.pl:42:9:compare:1"]).
timeout_ms(5000).                     % time limit per mutant is
timeout_factor(1.5).                  %   factor * covering tests' time + timeout_ms
stack_limit('1g').                    % for each worker process
concurrency(0).                       % workers; 0 means CPU count - 1
retries(1).                           % extra attempts for a mutant that crashes a worker
worker_reuse(0).                      % replace a worker after N mutants; 0 never
thresholds(high(80), low(60), break(0)). % report colours; exit 1 below break
reporters([clear_text, progress, html, json]).
report_dir("reports/mutation").
```

In the reports a score at or above `high` shows green, at or above `low` amber, and below `low` red. Set `break` above 0 to fail CI when the score drops below it.

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

1. **Read.** Each file is read with SWI-Prolog's own reader (`prolog_read_source_term/4`), so operators, quoting, dicts and strings are handled exactly as the compiler handles them. That includes operators imported from libraries. Each clause comes with its subterm positions, so a mutant can be reported as a character range and a replacement.
2. **Dry run.** A child `swipl` loads the tests and runs each one under SWI-Prolog's coverage instrumentation. It records how long each test took and which clauses of the mutated files it entered. A failing test stops the run, because mutants can only be judged against a green suite.
3. **Mutants.** A pool of child processes, one per worker, applies each mutant by reloading its file from the source text with the replacement spliced in. A worker then runs only the tests that entered the mutated clause, stopping at the first failure. Mutants with no covering test are settled without running anything.
4. **Time limits.** Each mutant gets a limit of `timeout_factor` times its covering tests' dry-run time, plus `timeout_ms`. The worker enforces it with `call_with_time_limit/2`. Code under test can catch that exception and loop on, so the controller also enforces a hard limit 10 seconds later. It kills a worker that misses it and starts a fresh one.
5. **Scheduling and retries.** Mutants with the longest limits start first, so a slow mutant doesn't leave the other workers idle at the end. A mutant that crashes its worker is tried again on a fresh worker, up to `retries` times. Timeouts aren't retried, because a timeout already counts as detected. Results are reported in source order whatever the order they finished in.

`mutalog list --check` re-reads every spliced mutant and compares it with the clause the runner will load.

## Roadmap

1. **Read and generate**: `mutalog list`. Done.
2. **Dry run and worker**: `mutalog run` and `mutalog dry-run` with one worker. Done.
3. **Pool, scheduler, timeouts**: parallel workers, longest-first scheduling, hard time limits, retries for crashes. Done.
4. **Reports and thresholds**: clear text, JSON in the open mutation-testing report schema, a self-contained HTML report, `break` threshold exit code. Done.
5. **Release**: BSD-2-Clause license, installable as a pack with a `swipl mutalog` app, versioned releases.

## Development

```sh
swipl test/run.pl                                    # tests
bin/mutalog list --mutate 'prolog/**/*.pl' --check   # Mutalog's own mutants re-read
(cd test/project && ../../bin/mutalog run)           # the example project
```

## License

BSD-2-Clause. See [LICENSE](LICENSE).
