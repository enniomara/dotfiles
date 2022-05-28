#!/bin/bash

# Given a Pull request opened by Renovate for a package, find out the commit
# hashes and their titles that have been added from the current version
# (checked in the repo) to the commit that renovate wants to update it to.

set -e

if [[ -z "${GH_OAUTH_TOKEN}" ]]; then # zero-length check
  echo "Github oauth token is not set, exiting"
  exit 1
fi

pr_body=$(cat - | jq -r '.body')

# The repo name looks like
# [ojroques/vim-oscyank](https://togithub.com/ojroques/vim-oscyank), but since
# a regex will match all urls, look after a | in the beginning to only match
# the repo (the repo is shown in a markdown table, which start with a |)
repo_name=$(echo "$pr_body" | gawk 'match($0, "\\| \\[(.*\\/.*)\\]\\(", a) {print a[1]}')
echo '----------------------------------------'
echo "Looking for commits in '$repo_name' repo"
printf '\n'

# The commit text looks like `23b0846` -> `ebcb47d`
basehead=$(echo "$pr_body" | gawk 'match($0, "`(.*)` -> `(.*)`", a) {printf "%s...%s",a[1],a[2]}')


diff=$(curl -L -s --header "Authorization: token $GH_OAUTH_TOKEN" "https://api.github.com/repos/$repo_name/compare/$basehead")
# Query commits since, and extract sha and commit message. Sometimes commits
# can be multiline, the gsub removes everything after the newline so only the
# title is shown
commits=$(echo "$diff"| jq '.commits[].commit | "\(.tree.sha): \(.message | gsub("\\n(.*)"; "") )"')

echo "$commits"
