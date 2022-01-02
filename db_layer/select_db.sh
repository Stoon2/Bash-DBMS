#!/bin/bash
select s_db in $(ls $(pwd)/db_collection/)
do
    cd "$(pwd)/db_collection/$s_db"
    echo "$(pwd)"
    exit
done