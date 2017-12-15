#!/bin/bash

echo "runtest.sh is running..."

#   Variables
# echo enter number of users: $numberOfUsers
    #for i in {1..$users}TH
#deleteSynFile="rm synthetic.dat"
resultFile="result.dat"
# loadtest=`./loadtest`
# read numberOfUsers

if [[ $1 -ge 1 && $1 -le 150 ]] ; then 
    echo "Accepted input"
    rm "synthetic.dat"
    rm $resultFile
    touch $resultFile
    
    echo CO$'\t'N$'\t'idle >> $resultFile 
    users=$1
    seconds=$2
    for((i=1;i<=$1;i++))
     do
        timeout $seconds ./loadtest $i &
         # printf " %-20s %-20s %-20s\n " CO\ N\ Idle
         #wc -l < synthetic.dat >> "$resultFile"
         CO=`wc -l < synthetic.dat`
         #echo $CO
        #echo $i >> "$resultFile"
        N="$i"
         #mpstat -o JSON | jq -r '.sysstat.hosts[0].statistics[0]."cpu-load"[0].idle' >> $resultFile
        idle=`mpstat 10 1 -o JSON | jq -r '.sysstat.hosts[0].statistics[0]."cpu-load"[0].idle'`
        echo $idle
        echo $CO$'\t'$i$'\t'$idle >> $resultFile
     done

     echo "All done"
else
  echo "Bad inputs, try again or exit"
fi


#./loadtest $numberOfUsers



# for i in {1..20}
# do
  #  echo $i
    # do something here
# done
