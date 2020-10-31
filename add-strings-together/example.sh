#!/bin/bash
count=4
src="a"
response=""
i=0
while [[ $i -lt $count ]]; do
  response+=$src
  i=$i+1
done
echo $response
