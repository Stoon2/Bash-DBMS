#!/bin/bash
<<<<<<< HEAD

mkdir -p "$(pwd)/db_collection/$1/"
chmod a+x "$(pwd)/db_collection/$1/" # insure execute permission is given on created dirs
echo $1 is created successfully
=======
#add key to abort
DIR="db_collection/$1"
  if [ ! -d "$DIR" ]
then
  mkdir -p "$(pwd)/db_collection/$1/"
  chmod a+x "$(pwd)/db_collection/$1/" # insure execute permission is given on created dirs
  if [[ $? == 0 ]]
  then
    echo "$1 Database created successfully"
  else
    echo "Error creating database $1"
  fi
else
    echo "$1 Database already exists or input is incorrect"
    exit
fi
>>>>>>> 69dce984b9c03c9f36756e543495e88173fe9e2c
