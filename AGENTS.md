# Agent guidelines

Mutalog is a standalone, general-purpose mutation testing library for
SWI-Prolog. Keep it independent of any particular downstream project.

- Do not name or reference specific downstream or consumer projects in
  code, comments, tests, fixtures, examples, CI workflows, docs, commit
  messages or pull request descriptions. Use the bundled fixture project
  in `test/project/` or generic examples instead.
- Validation against real-world codebases happens outside this
  repository; report only generic findings here.

## Development

```sh
swipl test/run.pl                              # tests
bin/mutalog list --mutate 'prolog/**/*.pl' --check  # mutants of Mutalog itself
(cd test/project && ../../bin/mutalog run)     # the example project
```
