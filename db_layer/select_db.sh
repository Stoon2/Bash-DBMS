#!/bin/bash
PS3="Action:"
select s_db in $(ls $(pwd)/db_collection/)
do
    cd "$(pwd)/db_collection/$s_db" 2>>erro r.log && echo "Database <$s_db> Selected Successfully"
    echo "$(pwd)"
    exit
done