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
  knowledge base (`.kb/`), `package.json`, the `kibi-report` workflow
  and the README badge may name it. Library code, tests, fixtures,
  examples and the pack itself stay free of it, and commit messages and
  pull request descriptions mention it only to name the tool.

## Development

```sh
swipl test/run.pl                              # tests
bin/mutalog list --mutate 'prolog/**/*.pl' --check  # mutants of Mutalog itself
(cd test/project && ../../bin/mutalog run)     # the example project
```

## Releasing

Releases go through the Release workflow (see the README's Releasing
section). A version bump in `pack.pl` and its `CHANGELOG.md` section
land together in one pull request, before the release is run. Never
create release tags by hand.

## Knowledge base

Requirements and decisions live in `.kb/` and are managed with Kibi
(`npm ci`, then `npm exec -- kibi <command>`). Run `kibi check` after
changing them; `kibi report` builds the requirement-health report.
