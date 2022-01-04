#!/bin/bash
PS3="Action:"
shopt -s expand_aliases;
alias dir=$(pwd)/db_collection/;
function ss { $(pwd)/bash table.sh };
if [ ! "$(ls -A $(pwd)/db_collection/ 2>/dev/null)" ]
then
    echo 'No databases to Select';
    exit
else
    select select_db in $(ls $(pwd)/db_collection/)
    do
        cd "$(pwd)/db_collection/$select_db"
        echo "$(pwd)"
        #bash ../../table.sh
        exit
    done
fi
