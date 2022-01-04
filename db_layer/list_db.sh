#!/bin/bash
if [ ! -d "$(pwd)/db_collection" ]
then
    echo "db_collection directory does not exist, please create a DB through 'Create a DB' in the main menu."
elif [ ! "$(ls -A $(pwd)/db_collection/ 2>/dev/null)" ]
then
    echo No databases exist, please create a database.
else
    ls db_collection 2>/dev/null
fi