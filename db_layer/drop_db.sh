#!/bin/bash
PS3="Number:"

if [ ! "$(ls -A $(pwd)/db_collection/ 2>/dev/null)" ]
then
    echo No databases to drop
    exit
else 
    echo Choose a DB Number To Drop
fi
select s_db in $(ls $(pwd)/db_collection/)
do
    read -p "Are you sure you want to delete $s_db ? (Y/N): "
    case $REPLY in
        [yY]*) 
            rm -r "$(pwd)/db_collection/$s_db" 
            echo $s_db has been dropped successfully
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
