#!/bin/bash
if [ ! -d "$(pwd)/db_collection" ] #Validation Checking the existance for the main DIR
then
    echo "db_collection directory does not exist, please create a DB through 'Create a DB' in the main menu."
elif [ ! "$(ls -A $(pwd)/db_collection/ 2>/dev/null)" ] #Validation Checking the existance of the DBs
then
    echo No databases exist, please create a database.
else
    ls db_collection 2>/dev/null #List it then move the output to blackhole 
fi