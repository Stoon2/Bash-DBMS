#!/bin/bash
PS3="Action:"

if [ ! "$(ls -A $(pwd)/db_collection/ 2>/dev/null)" ]
then
    echo 'No databases to select'
    exit
else 
    echo 'Choose DB number to select'
fi

select s_db in $(ls $(pwd)/db_collection/)
do
    cd "$(pwd)/db_collection/$s_db"
    echo "$(pwd)"
    # Echo selected database here at a later time
    exit
done