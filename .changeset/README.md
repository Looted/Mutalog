# Changesets

Each pull request that changes what a Mutalog user sees adds a
changeset here: a Markdown file that names the semver bump and says
what changed. `npm run version-packages` consumes them into the next
version in `pack.pl` and its `CHANGELOG.md` section, and merging that
to `master` releases it. See the README's Releasing section.

```sh
npm run changeset            # add a changeset
npx changeset status         # what the next version would be
npm run version-packages     # consume the changesets into a release
```

A changeset looks like this:

```md
---
"mutalog": patch
---

One or two sentences on what a user of the pack sees change. Further
paragraphs can give details or migration steps.
```

Use `patch` for fixes, `minor` for new features or behaviour a
project may need to adapt to, and `major` for breaking changes once
Mutalog reaches 1.0.
