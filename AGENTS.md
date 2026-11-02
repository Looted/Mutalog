# Agent guidelines

Mutalog is a standalone, general-purpose mutation testing library for
SWI-Prolog. Keep it independent of any particular downstream project.

- Do not name or reference specific downstream or consumer projects in
  code, comments, tests, fixtures, examples, CI workflows, docs, commit
  messages or pull request descriptions. Use the bundled fixture project
  in `test/project/` or generic examples instead.
- Validation against real-world codebases happens outside this
  repository; report only generic findings here.
- Exception: the repository uses Kibi as development tooling. Its
  knowledge base (`.kb/`), `proof/steps.json`, `package.json`, the
  `kibi-report` workflow and the README badge may name it. Library
  code, tests, fixtures, examples and the pack itself stay free of it,
  and commit messages and pull request descriptions mention it only to
  name the tool.

## Development

```sh
swipl test/run.pl                              # tests
swipl test/run.pl e2e:operator_arith           # one test
swipl test/coverage.pl                         # tests under clause coverage
bin/mutalog list --mutate 'prolog/**/*.pl' --check  # mutants of Mutalog itself
(cd test/project && ../../bin/mutalog run)     # the example project
```

`test/coverage.pl` records clause coverage in the test process and in
every `swipl` it starts (the CLI and its workers), and fails unless
every clause of `prolog/` is entered. CI runs it on SWI-Prolog 9.0.
Pool threads are not recorded there, so pool code needs a test that
calls it from the main thread. A clause coverage cannot record goes
in `unrecorded/3` with the test that shows it runs.

Mutalog's own mutation run (about four minutes, score 99.5%):

```sh
bin/mutalog run --mutate prolog/mutalog.pl \
  --mutate 'prolog/mutalog/{client,config,discover,generate,operators,reader,report,run}.pl' \
  --tests test/test_mutalog.plt -c 3
```

`worker.pl` and `coverage.pl` are left out because the worker that
applies the mutants is built from them, and the end-to-end tests are
left out because they run `bin/mutalog` from the files on disk, so
they cannot see a mutant. The survivors left are equivalent mutants.

## Releasing

Releases are driven by changesets (see the README's Releasing section).
Add a changeset (`npm run changeset`) in the same pull request as any
change users of the pack would notice, written for the changelog:
what changes for them first, details after. Don't edit the version in
`pack.pl` or `package.json`, or add `CHANGELOG.md` sections, by hand;
`npm run version-packages` does both in a release pull request, and
merging it to `master` publishes. Never create release tags by hand.

## Knowledge base

Requirements and decisions live in `.kb/` and are managed with Kibi
(`npm ci`, then `npm exec -- kibi <command>`). Run `kibi check` after
changing them; `kibi report` builds the requirement-health report.

Each requirement is proved by one end-to-end test in
`test/test_e2e.plt`, which runs `bin/mutalog` or the installed pack as
a separate process. The chain is requirement, `specified_by` scenario,
`verified_by` test, with the test's symbol `executable_for` it and the
predicates behind the requirement `implements` it and `covered_by` the
test. `proof/steps.json` maps each test to its command. After adding
or changing one, run `kibi sync`, `kibi check` and `kibi prove --all`;
the report workflow proves again before it publishes.

`kibi-plugin-treesitter` with `kibi-lang-prolog` and `kibi-lang-bash`
gives symbols their real predicate spans, so a symbol needs no
`granularity_reason` unless the extractor cannot find it.

A requirement is tested only when one of its scenarios also covers the
failure side: `expects: rejection`, `assumes` a fact that opposes the
claim, and is verified by an end-to-end test that tries to break the
guarantee. A claim Kibi can read from the code is proved instead by a
`TEST-cert-*` source proof, which reads Prolog facts (`prolog` reader)
or the calls and imports of Prolog files (`references` reader); a
proved claim needs no failure-side scenario.

A claim that needs the code run, not only read, is proved by a
certificate: a script in `proof/` (for example `proof/config_keys.pl`)
loads the library, checks every member of a domain Kibi reads from the
code itself, and writes the certificate with `proof/kibi_certificate.pl`.
A constant (a margin, a schema version) is proved the same way: the
library names it in a one-clause predicate, and the script reads it
through that predicate and writes an arithmetic or regex certificate
(`proof/hard_limit.pl`, `proof/report_schema.pl`).
The references reader cannot read a file that loads files named at run
time (`worker.pl`) or prints message lines held in a variable, so code a
source proof reads lives in files without those (`coverage.pl`).
