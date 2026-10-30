// Changelog lines for `changeset version`: each changeset becomes one
// bullet in its version's CHANGELOG.md section, without a commit hash.
// scripts/sync-version.mjs then dates the section and removes the
// "### Patch Changes" style headings changesets adds around them.

async function getReleaseLine(changeset) {
  const [first, ...rest] = changeset.summary.trim().split('\n').map((l) => l.trimEnd());
  return [`- ${first}`, ...rest.map((l) => (l ? `  ${l}` : ''))].join('\n');
}

async function getDependencyReleaseLine() {
  return '';
}

module.exports = { default: { getReleaseLine, getDependencyReleaseLine } };
