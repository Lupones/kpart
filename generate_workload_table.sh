#!/bin/bash
# set -x


#workloads=/home/lupones/manager/experiments/$1/workloads$1.yaml
workloads=/home/lupones/kpart/tests/$1.yaml
inputdir=/home/lupones/kpart/tests
outputdir=/home/lupones/kpart/tests

sudo python3 ./generate_workload_table.py -w $workloads -id $inputdir -od $outputdir
