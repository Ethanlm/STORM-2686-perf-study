#!/bin/bash

if [ $# -ne 4 ] 
    then
        echo "USAGE: $0 NUM_VM NUM_WORKERS RATE LOG_ROOT_DIR"
        exit -1
fi

NUM_VM=$1
NUM_WORKERS=$2
RATE=$3
ROOT_DIR=$4
#ROOT_DIR=/home/ethanli/STORM-2686-perf-study/raw-results/tmp/

# simple test has the same number of all components and workers
NUM_SPOUTS=$NUM_WORKERS
NUM_SPLITTERS=$NUM_WORKERS
NUM_COUNTERS=$NUM_WORKERS

TIMESTAMP=$(date -u +\%Y\%m\%d\%H\%M\%S)

# the relative path also serves the unique id for each experiment
RELATIVE_PATH=${NUM_VM}vm${NUM_SPOUTS}spout${NUM_SPLITTERS}splitter${NUM_COUNTERS}counter${RATE}r.${TIMESTAMP}
LOG_FILE_DEST=${ROOT_DIR}/${RELATIVE_PATH}

COMMAND="storm jar /tmp/storm-loadgen-2.0.0-SNAPSHOT.jar org.apache.storm.loadgen.ThroughputVsLatency 
         --spouts $NUM_WORKERS   
         --splitters $NUM_WORKERS 
         --counters $NUM_WORKERS
         --rate $RATE
         --reporter TSV:$LOG_FILE_DEST 
         -c topology.workers=$NUM_WORKERS
         "

eval $COMMAND

echo "RESULTS SAVED AT ${LOG_FILE_DEST}"
