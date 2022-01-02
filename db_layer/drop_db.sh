#!/bin/bash
select s_db in $(ls $(pwd)/db_collection/)
do
    rm -r "$(pwd)/db_collection/$s_db"
    exit
done