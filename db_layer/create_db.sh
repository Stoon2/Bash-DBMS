#!/bin/bash
DIR="db_collection/$1"
if [ ! -d "$DIR" ] #Validation Checking the existance of the DB
then
  mkdir -p "$(pwd)/db_collection/$1/" #Creating DB
  chmod a+x "$(pwd)/db_collection/$1/" #Insure execute permission is given on created dirs
  if [[ $? == 0 ]] #Validation Checking the process
  then
    echo "$1 Database created successfully" #Sucess
  else
    echo "Error creating database $1" #Error
  fi
else
    echo "$1 Database already exists or input is incorrect"  
    exit
fi
