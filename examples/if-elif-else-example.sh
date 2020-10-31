#!/bin/bash
# REF: https://stackoverflow.com/questions/16034749/if-elif-else-statement-issues-in-bash
seconds=$1

if [[ "$seconds" -eq 0 ]]; then
   timezone_string="Z"
elif [[ "$seconds" -gt 0 ]]; then
   timezone_string=$(printf "%02d:%02d" $((seconds/3600)) $(((seconds / 60) % 60)))
else
   echo "Unknown parameter"
fi

echo $timezone_string
