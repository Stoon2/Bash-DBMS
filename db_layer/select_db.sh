#!/bin/bash
PS3="Choose:"
DIR="$(pwd)/db_collection"
if [ ! "$(ls -A $(pwd)/db_collection/ 2>/dev/null)" ]
then
    echo 'No databases to select';
    exit
else
    select select_db in $(ls $(pwd)/db_collection/) #Need Validation
    do
        cd "$(pwd)/db_collection/$select_db"
        echo "$(pwd)"
        exit
    done
fi
