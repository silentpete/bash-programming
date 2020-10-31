#!/bin/bash
# REF: https://www.cyberciti.biz/faq/bash-while-loop/
x=1
while [[ $x -le 5 ]]; do
  echo "Welcome $x times"
  x=$(( $x + 1 ))
done
