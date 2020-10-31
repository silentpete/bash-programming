#!/bin/bash

# Capture directory of script to use for pathing.
CWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Create an Array to house all the folder names that contain a .git directory.
declare -a folder_names_array

# From the CWD, find all paths to the .git dir
for file in $(find ${CWD} -maxdepth 2 -type d -iname ".git"); do
  # remove the filename from the path
  filepath=$(dirname "${file}")
  # same off the folder names into the array
  folder_names_array+=("${filepath##*/}")
done

for folder in ${folder_names_array[@]}; do
  # Do something to each folder
  echo $folder
done
