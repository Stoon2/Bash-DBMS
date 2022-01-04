#!/bin/bash

PS3="Number:"


if [ ! "$(ls -A $1 2>/dev/null)" ]
then
    echo "No Tables to delete"
    exit
else 
    echo Choose a Table Number To delete
fi
select drop_tb in $(ls $1)
do
    read -p "Are you sure you want to delete $drop_tb ? (Y/N): "
    case $REPLY in
        [yY]*) 
            rm "$1/$drop_tb" 
            rm "$1/".$drop_tb""
            echo $drop_tb has been Deleted Successfully
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
