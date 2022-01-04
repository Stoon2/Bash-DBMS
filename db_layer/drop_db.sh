#!/bin/bash
PS3="Number:"

if [ ! "$(ls -A $(pwd)/db_collection/ 2>/dev/null)" ]
then
    echo No databases to drop
    exit
else 
    echo Choose a DB Number To Drop
fi
select drop_db in $(ls $(pwd)/db_collection/)
do
    read -p "Are you sure you want to delete $drop_db ? (Y/N): "
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
