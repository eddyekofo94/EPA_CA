#!/bin/bash

echo "runtest.sh is running..."

#   Variables
echo enter number of users: $numberOfUsers
resultFile="./result.dat"
# loadtest=`./loadtest`
read numberOfUsers

if [[ $numberOfUsers -ge 1 && $numberOfUsers -le 50 ]] ; then 
     
    echo "Accepted input"
    users=$numberOfUsers
    for i in {1..50}
     do
         if [ -e "$resultFile" ]; then
         ./loadtest $users& >> `mpstat -o JSON >> test_result.json`

             #./loadtest $users& >> `mpstat -o JSON >> test_result.json`
        fi    
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
