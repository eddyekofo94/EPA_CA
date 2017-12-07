#!/bin/bash

echo "runtest.sh is running..."

#   Variables
echo enter number of users: $numberOfUsers

# loadtest=`./loadtest`
read numberOfUsers

if [[ $numberOfUsers -ge 1 && $numberOfUsers -le 50 ]] ; then 
  echo "good"
else
  echo "bad"
fi


#./loadtest $numberOfUsers



# for i in {1..20}
# do
  #  echo $i
    # do something here
# done
