#!/bin/bash
DIR="db_collection/$1"
  if [ ! -d "$DIR" ]
then
  mkdir -p "$(pwd)/db_collection/$1/"
  chmod a+x "$(pwd)/db_collection/$1/" # insure execute permission is given on created dirs
  if [[ $? == 0 ]]
  then
    echo "$1 Database is created successfully"
  else
    echo "Error Creating Database $1"
  fi
else
    echo "$1 Database is already exist"
    exit
fi
