#!/usr/bin/env node
// Finish `changeset version` for a pack: copy the new version from
// package.json into pack.pl, and give its CHANGELOG.md section the
// layout of the others.
//
//   node scripts/sync-version.mjs [YYYY-MM-DD]
//
// changesets writes the section as "## X.Y.Z" with "### Minor Changes"
// style headings, directly under the "# Changelog" title. This dates
// the heading, drops those subheadings and moves the section below the
// introduction. A section that is already dated is left as it is, so
// running it twice changes nothing. Run from the repository root.

import { readFileSync, writeFileSync } from 'node:fs';

const fail = (msg) => {
  console.error(`sync-version: ${msg}`);
  process.exit(1);
};

const { version } = JSON.parse(readFileSync('package.json', 'utf8'));
if (!/^\d+\.\d+\.\d+$/.test(version ?? '')) fail(`package.json version '${version}' is not X.Y.Z`);

const pack = readFileSync('pack.pl', 'utf8');
const versionLine = /^version\('[^']*'\)\./m;
if (!versionLine.test(pack)) fail("no version('X.Y.Z') line in pack.pl");
writeFileSync('pack.pl', pack.replace(versionLine, `version('${version}').`));

const date = process.argv[2] ?? new Date().toISOString().slice(0, 10);
const lines = readFileSync('CHANGELOG.md', 'utf8').split('\n');
const start = lines.findIndex((l) => l.trim() === `## ${version}`);
if (start === -1) {
  if (!lines.some((l) => l.startsWith(`## ${version} `))) {
    fail(`CHANGELOG.md has no '## ${version}' section; add a changeset first`);
  }
} else {
  // changesets inserts the section above the introduction, so it ends at
  // the first line scripts/changelog.cjs can't have written: one that is
  // not blank, a heading, a bullet or an indented continuation.
  let end = lines.findIndex(
    (l, i) => i > start && (l.startsWith('## ') || !/^(|### .*|- .*|  .*)$/.test(l)),
  );
  if (end === -1) end = lines.length;
  const body = lines
    .slice(start + 1, end)
    .filter((l) => !/^### \w+ Changes$/.test(l))
    .join('\n')
    .replace(/\n{3,}/g, '\n\n')
    .trim();
  const rest = [...lines.slice(0, start), ...lines.slice(end)];
  let at = rest.findIndex((l) => l.startsWith('## '));
  if (at === -1) at = rest.length;
  const before = rest.slice(0, at).join('\n').trimEnd();
  const after = rest.slice(at).join('\n').trimEnd();
  const section = `## ${version} (${date})\n\n${body}`;
  writeFileSync('CHANGELOG.md', [before, section, after].filter(Boolean).join('\n\n') + '\n');
}

console.log(version);
