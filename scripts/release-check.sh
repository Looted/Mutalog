#!/usr/bin/env bash
# Check that the version in pack.pl is ready to release.
#
#   scripts/release-check.sh             check pack.pl against CHANGELOG.md
#   scripts/release-check.sh --untagged  also require that its tag is unused
#   scripts/release-check.sh --tag vX.Y.Z  also require pack.pl to match a tag
#
# Prints the version on success. Run from the repository root.
set -euo pipefail

version=$(sed -n "s/^version('\([^']*\)')\..*/\1/p" pack.pl)
fail() { echo "release-check: $*" >&2; exit 1; }

[ -n "$version" ] || fail "no version('X.Y.Z') line in pack.pl"
[[ $version =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] \
  || fail "pack.pl version '$version' is not X.Y.Z"
grep -q "^## $version\b" CHANGELOG.md \
  || fail "CHANGELOG.md has no '## $version' section for the version in pack.pl"
[ -n "$(scripts/release-notes.sh "$version")" ] \
  || fail "the '## $version' section of CHANGELOG.md is empty"

case "${1:-}" in
  --untagged)
    if git ls-remote --exit-code --tags origin "refs/tags/v$version" > /dev/null; then
      fail "tag v$version already exists; bump the version in pack.pl and add a CHANGELOG.md section"
    fi ;;
  --tag)
    [ "${2:-}" = "v$version" ] || fail "tag ${2:-} does not match pack.pl version $version" ;;
  '') ;;
  *) fail "unknown option $1" ;;
esac

echo "$version"
