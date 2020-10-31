#!/bin/bash

if [[ ! -z "${DEV}" ]]; then
  echo 'DEV env var is set'
fi

if [[ "${DEV}" == "true" ]]; then
  echo 'DEV is equal to true'
fi

if [[ ! -z "${DEV}" && "${DEV}" == "true" ]]; then
  echo 'DEV env var is set and equal to true'
fi

# TESTS
# success run with: DEV=true ./test_if_VAR_set_and_equal_to_true.sh
# fail run with: ./test_if_VAR_set_and_equal_to_true.sh
# fail run with: DEV="" ./test_if_VAR_set_and_equal_to_true.sh
# fail run with: DEV="anythingNotTrue" ./test_if_VAR_set_and_equal_to_true.sh
