#!/bin/bash

declare -a ary_a=('a' 'b' 'c')
declare -a ary_b=('a' 'b')
declare -a ary_c=()

for i in ary_a[@]; do
  echo $i
  for j in ary_b[@]; do
    if [[ "${i}" != "${j}" ]]; then
      ary_c+=("${i}")
    fi
  done
done

for x in ary_c[@]; do
  echo -e "${x}"
done
