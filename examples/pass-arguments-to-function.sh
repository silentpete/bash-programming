#!/bin/bash

# Define Function/s
# Make sure to note what is needed in the comments
function function_name() {
  echo "all arguments: ${@}"
  echo "argument count: ${#}"
  echo "argument 1: $1"
  echo "argument 2: $2"
}

# Define Variables
arg1="arg 1"
arg2="arg 2"

# can now use the function
function_name "$arg1" "$arg2"
