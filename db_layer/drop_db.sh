#!/bin/bash
PS3="Database to Drop:"
if [ ! "$(ls -A $(pwd)/db_collection/ 2>/dev/null)" ] #Validation Checking the existance of the DB
then
    echo "No databases to drop" #Empty NO DBs
    exit
else 
    echo "Choose a DB Number To Drop" #There is DBs
fi
select drop_db in $(ls $(pwd)/db_collection/) #Selecting the DB to drop
do
    read -p "Are you sure you want to delete $drop_db ? (Y/N): " #Confirmation
    case $REPLY in
        [yY]*) 
            rm -r "$(pwd)/db_collection/$drop_db" 
            echo $drop_db has been Deleted Successfully
            exit
        ;;
        [nN]*) 
            echo " Operation Canceled"
        ;;
        *) 
            echo "Invalid option"
        ;;
    esac
    exit
done
