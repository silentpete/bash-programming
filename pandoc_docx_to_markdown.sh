#!/bin/bash
#
# Can set environment variable DRYRUN to anything and will only echo out command.
#
# Example
# cd to files
# run this script
#

[[ -n ${VERBOSE} ]] && echo 'set exit on error'
set -e

[[ -n ${VERBOSE} ]] && echo 'save current IFS'
old_IFS=$IFS
[[ -n ${VERBOSE} ]] && echo 'set new IFS'
IFS=$'\n'

for docx in $(find . -type f -iname '*.docx'); do
  echo "working on file: ${docx}"

  dir_of_file=$(dirname "${docx}")
  [[ -n ${VERBOSE} ]] && echo "directory name without file: ${dir_of_file}"

  name_of_file=$(basename "${docx%.docx}")
  [[ -n ${VERBOSE} ]] && echo "file name without extension: ${name_of_file}"

  name_no_spaces=${name_of_file// /_}
  [[ -n ${VERBOSE} ]] && echo "file name without extension: ${name_no_spaces}"

  ${DRYRUN+echo} pandoc "${docx}" --from=docx --to=markdown_strict --output="${dir_of_file}/${name_no_spaces}.md" --wrap=none --markdown-headings=atx --incremental --standalone --no-highlight
  # ${DRYRUN+echo} pandoc "${docx}" --from=docx --to=markdown_strict --output="${dir_of_file}/${name_no_spaces}.md" --standalone --no-highlight  # was recommended from pandoc converter tool

  ${DRYRUN+echo} sed -i '1s/^/# /' "${dir_of_file}/${name_no_spaces}.md"
done

[[ -n ${VERBOSE} ]] && echo 'return IFS to original'
IFS=${old_IFS}
