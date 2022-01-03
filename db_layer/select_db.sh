#!/bin/bash
PS3="Action:"

if [ ! "$(ls -A $(pwd)/db_collection/ 2>/dev/null)" ]
then
    echo 'No databases to Select'
    exit
else 
    echo 'Choose DB number to Select'
        select select_db in $(ls $(pwd)/db_collection/)
        do
        cd "$(pwd)/db_collection/$select_db"
        #bash ../table.sh #need to be modified to connect it to table.sh in main parent directory
        exit
done
fi
