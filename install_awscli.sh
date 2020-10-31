#!/bin/bash

# Reference: https://docs.aws.amazon.com/cli/latest/userguide/install-linux.html#install-linux-path

if [[ $EUID -eq 0 ]]; then
  echo "This script should not be run using sudo or as the root user"
  exit 1
fi

pip install awscli --upgrade --user

aws --version
