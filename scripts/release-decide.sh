#!/usr/bin/env bash
# Decide whether a Release workflow run publishes the version in pack.pl.
#
# Reads the GITHUB_REF, GITHUB_REF_TYPE, GITHUB_REF_NAME and
# GITHUB_EVENT_NAME variables that GitHub Actions sets, and appends
# release=true or release=false to $GITHUB_OUTPUT.
#
#   a vX.Y.Z tag                 release if it matches pack.pl
#   a push to master             release if the version has no tag yet,
#                                otherwise release=false
#   a manual run on master       release if the version has no tag yet,
#                                otherwise fail: there is nothing to retry
#   anything else                fail
#
# Every release also needs scripts/release-check.sh to pass. Run from
# the repository root.
set -euo pipefail

: "${GITHUB_OUTPUT:?GITHUB_OUTPUT is not set}"

if [ "${GITHUB_REF_TYPE:-}" = tag ]; then
  scripts/release-check.sh --tag "$GITHUB_REF_NAME" > /dev/null
elif [ "${GITHUB_REF:-}" != refs/heads/master ]; then
  echo "Run the release from master, not ${GITHUB_REF_NAME:-${GITHUB_REF:-}}." >&2
  exit 1
else
  version=$(scripts/release-check.sh)
  if [ "${GITHUB_EVENT_NAME:-}" = push ] \
      && git ls-remote --exit-code --tags origin "refs/tags/v$version" > /dev/null; then
    echo "v$version is already released; nothing to do."
    echo "release=false" >> "$GITHUB_OUTPUT"
    exit 0
  fi
  scripts/release-check.sh --untagged > /dev/null
fi
echo "release=true" >> "$GITHUB_OUTPUT"
