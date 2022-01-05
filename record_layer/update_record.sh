#!/bin/bash

# ------------------------------------------------------
# This script assumes its running from project root dir
# ------------------------------------------------------
total_cols="\0"
curr_delim="\0"
DIR="$(pwd)/db_collection"
# $1 argument 1 is db name
# $2 argument 2 is table name

# validation for db_collection folder
if [ ! -d $DIR ]
then
    echo "db_collection directory does not exist, please create a DB through 'Create a DB' in the main menu."
    exit
# assumes curr_db and curr_table are passed to script, check if they exist
elif [ ! "$(ls -A $1 2>/dev/null)" ] 
then
    echo No $1 database exists, please create a database.
    exit
elif [ ! "$(ls -A $1/$2 2>/dev/null)" ]
then
    echo No $2 table exists, please create a table.
    exit
else
    # declare constraints from metadata and table
    t_path="$1/$2"
    ht_path="$1/.$2"
    total_cols=$(tail -n1 $ht_path | grep -o ":" | wc -l) # provides num of cols from metadata
    curr_delim=$(head -n1 $ht_path | cut -d: -f2) # provides current delimeter from metadata
    total_records=$(wc -l $t_path | cut -d' ' -f1) # provides current delimeter from metadata
fi

read

sel_list=$(sed -n 3p $ht_path);
sel_list=${sel_list:10}; # remove col_name from hidden fi

select select_col in $(echo $sel_list | sed 's/:/ /g') "Exit"
do
    case $select_col in
        "Exit" )
            exit
        ;;
        $select_col )
            picked_field=0;
            for ((i=1; i<=$total_cols; i++))
            do
                if [ "$(echo $sel_list | cut -d: -f$i)" == "$select_col" ]
                then
                    picked_field=$i
                    break
                fi
            done
            read -p "What do you want to update in column $select_col?: ";
            
            more $t_path | grep -nw $REPLY | sed 's/\^\_\^/:/g' | cut -d: -f1 # to find line numbers to update
            more $t_path | grep -w $REPLY | sed 's/\^\_\^/ | /g' | cut -d: -f1 # field to update in line, 
            # how to deal with multiple character delim? could convert ^_^ to : briefly
            # where a condition is matched by grep, cut the field and update it
    esac
done