#!/bin/bash

COMMAND=${1:-jq}

hash ${COMMAND} 2>/dev/null
exit_code=$?
if [[ ${exit_code} == 0 ]]; then
  echo "${COMMAND} found"
else
  echo "${COMMAND} could not be found"
  exit ${exit_code}
fi
