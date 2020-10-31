#!/bin/bash

answer=""
while [[ "$answer" == "" ]]; do
  echo -e "would you like to play a game?"
  read answer
  if [[ "$answer" == "n" ]]; then
    answer=false
  elif [[ "$answer" == "y" ]]; then
    answer=true
  else
    echo "incorrect, please y or n"
    answer=""
  fi
done

echo $answer
