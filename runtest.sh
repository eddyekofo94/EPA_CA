#!/bin/bash

echo "runtest.sh is running..."

#   Variables
#deleteSynFile="rm synthetic.dat"
resultFile="result.dat"

echo "Accepted input"
rm "synthetic.dat"
rm $resultFile
touch $resultFile

echo CO$'\t'N$'\t'idle >> $resultFile #writes the heading on each column 
users=$1  # inputs from the user
seconds=$2  #seconds for the timeout to kill
for((i=1;i<=$1;i++))
do
    timeout 10 ./loadtest $i &  # timout is a plugin which automatically closes processes
    CO=`wc -l < synthetic.dat` how many lines 
    N="$i"
    idle=`mpstat 10 1 -o JSON | jq -r '.sysstat.hosts[0].statistics[0]."cpu-load"[0].idle'`
    echo $idle
    echo $CO$'\t'$i$'\t'$idle >> $resultFile
done

    echo "DONE"