#!/usr/bin/env bash

ADDRESS=""
NUM_OF_REQUESTS=""
NUM_OF_REQUESTS_AT_A_TIME=""
REQ_PACKAGE="httpd-tools"
if [[ $(rpm -aq | grep -c ${REQ_PACKAGE}) -gt 0 ]]; then
  echo -e "found ${REQ_PACKAGE}"
else
  echo -e "did not find ${REQ_PACKAGE}"
  read -p "would you like to install ${REQ_PACKAGE}: [y/n]" answer
  if [[ "${answer}" == "y" ]]; then
    sudo yum install -y ${REQ_PACKAGE}
  else
    echo 'exiting'
    exit 1
  fi
fi

echo "How many requests would you like to send?"
read NUM_OF_REQUESTS

echo "How many requests at a time?"
read NUM_OF_REQUESTS_AT_A_TIME

echo "What address would you like to benchmark?"
read ADDRESS

ab -n ${NUM_OF_REQUESTS} -c ${NUM_OF_REQUESTS_AT_A_TIME} ${ADDRESS}

echo "script complete"
