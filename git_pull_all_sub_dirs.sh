#!/bin/bash

function info () {
  echo -e "\e[32mINFO: $@\e[0m"
}

function warn () {
  echo -e "\e[33mWARN: $@\e[0m"
}

function error () {
  echo -e "\e[31mERROR: $@\e[0m"
}

# Capture directory of script to use for pathing.
CWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# info "${CWD}"

# Get all folders and add to array.
declare -a folders_array

for file in $(find ${CWD} -iname ".git"); do
  folder=$(dirname "${file}")
  folders_array+=("$folder")
done

# info "${folders_array[@]}"

# go into each folder, then git pull
for git_dir in ${folders_array[@]}; do
  cd ${git_dir}
  info "pulling in ${git_dir}"
  git pull
done
