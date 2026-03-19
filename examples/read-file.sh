#!/bin/bash

# https://ss64.com/bash/read.html

# -r  Do not treat a Backslash as an escape character.

while IFS= read -r id; do
    echo "${0}: $id"
done < read-file.txt
