#!/bin/bash

# For every open pull request by Renovate in the repo, find out the difference
# in commits.

set -e

if [[ -z "${GH_OAUTH_TOKEN}" ]]; then # zero-length check
  echo "Github oauth token is not set, exiting"
  echo "Get it by running the following"
  printf '\n> export GH_OAUTH_TOKEN=$(gh config get -h github.com oauth_token)'
  exit 1
fi

pull_reqs=$(curl -s --header "Authorization: token $GH_OAUTH_TOKEN" "https://api.github.com/repos/enniomara/dotfiles/pulls" )
pull_requests_ids=$(echo "$pull_reqs" | jq '.[].number')

for id in $pull_requests_ids
do
    curl -s --header "Authorization: token $GH_OAUTH_TOKEN" "https://api.github.com/repos/enniomara/dotfiles/pulls/$id" | ./diff.sh
done

