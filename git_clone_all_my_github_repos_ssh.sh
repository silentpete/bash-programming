#!/bin/bash

# https://developer.github.com/v3/

# $ curl https://api.github.com/users/silentpete

# $ curl https://api.github.com/users/silentpete/repos


github_user=$(basename $(pwd))
echo "github user: ${github_user}"

# Capture directory of script to use for pathing.
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "script directory: ${script_dir}"

github_user_url="https://api.github.com/users/${github_user}"
echo "github user url: ${github_user_url}"

response=$(curl ${github_user_url}/repos)
echo "the response from git: $response"

repo_names=$(echo $response | jq '.[]."name"')
echo "repo names: $repo_names"

for repo in $repo_names; do
  r=$(echo $repo | sed 's|"||g')
  if [[ ! -d "$(pwd)/${r}" ]]; then
    echo "working with repo: ${r}"
    git clone "git@github.com:/${github_user}/${r}.git"
  fi
done
