#!/bin/bash
PS3="Number:"
#if [ -d db_collection/$name]
#then
select s_db in $(ls $(pwd)/db_collection/)
do
    read -p "Are you sure you want to delete $s_db ? (Y/N): " pick
    case $choise in
        [yY]*) rm -r "$(pwd)/db_collection/$s_db" exit;;
        [nN]*) echo " Operation Canceled";;
            *) echo "Invalid option";;
    esac
done
#else
    #echo "$name Database not exist"
#elseif
    #echo "Currently there is no Databases"
#fi