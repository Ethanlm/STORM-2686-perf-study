#!/bin/bash

if [ $# -ne 2 ] 
    then
        echo "USAGE: $0 NUM_VM [SHORT_DIR]"
        echo "The second argument can be any string, e.g. [ORIG/STORM-2686/SHUFFLE]. It will serve as an directory name."
        exit -1
fi

NUM_VM=$1

TIMESTAMP=$(date -u +\%Y\%m\%d\%H\%M\%S)
echo "Experiments begin at ${TIMESTAMP}"

ROOT_DIR="/home/ethanli/STORM-2686-perf-study/raw-results/$2/${TIMESTAMP}"
mkdir -p ${ROOT_DIR}

for repeat in 1 2 3
do
  for t in  1 2 4 
    do
      NUM_WORKERS=`expr ${NUM_VM} \* $t` 
      for RATE in 5000 10000 20000
        do
#        echo " sh /home/ethanli/STORM-2686-perf-study/runSimpleTest.sh ${NUM_VM} ${NUM_WORKERS} ${RATE} ${ROOT_DIR}"
         sh /home/ethanli/STORM-2686-perf-study/runSimpleTest.sh ${NUM_VM} ${NUM_WORKERS} ${RATE} ${ROOT_DIR}
        done
  done
done

TIMESTAMP=$(date -u +\%Y\%m\%d\%H\%M\%S)
echo "Experiments end at ${TIMESTAMP}"
