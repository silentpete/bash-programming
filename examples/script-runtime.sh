#!/bin/bash
start_time=`date +%s`
sleep 2
end_time=`date +%s`

runtime=$((end_time - start_time))

echo $runtime
