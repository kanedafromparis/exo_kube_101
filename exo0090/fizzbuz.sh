#!/usr/bin/env bash

IFS=$'\n\t'

# FB_SIZE=50 && export FB_SIZE
if [[ -z $FB_SIZE ]] 
then
  FB_SIZE=20;
fi 

x=1
while [ $x -le $FB_SIZE ]
do
  if [[ 0 -eq "($x%3) + ($x%5)" ]] 
  then
  # Check if divide by 3 & 5 #
    echo "fizz buzz"
  elif [[ 0 -eq "($x%5)" ]]
  then
  # Check if divide by 5 #   
    echo "buzz"
  elif [[ 0 -eq "($x%3)" ]]
  then
  # Check if divide by 3 #
    echo "fizz"
   else
    echo "$x"
   fi	
  x=$(( $x + 1 ))
done