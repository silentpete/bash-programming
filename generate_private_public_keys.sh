#!/bin/bash

account=""
type="rsa"
bits="2048"

echo -e "what account are we creating this ssh key for?"
read account

if [[ -n ${VERBOSE} ]]; then
  VERBOSE="-v"
else
  VERBOSE="-q"
fi

ssh-keygen ${VERBOSE} -t ${type} -b ${bits} -N "" -C "${account}" -f ./${account}_${type}
