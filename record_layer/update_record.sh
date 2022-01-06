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
    pk_exists=0;
    if [ $(sed -n 4p $ht_path | cut -d: -f2) == 1 ]
    then
        pk_exists=1
        total_cols=$(($total_cols-1))
    fi
fi

sel_list=$(sed -n 3p $ht_path);
sel_list=${sel_list:10}; # remove col_names from hidden file output

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
            echo "If your input is a string, please wrap it in single quotes like so 'input'!!!"
            echo
            
            # Checks if Primary Key exists, if so increment picked fields by 1 to compensate col names
            # p_tmp_field added as hot-fix
            if [ $pk_exists == 1 ];
            then
                tmp_field=$((picked_field+2))
                p_tmp_field=$((picked_field+1))
            else
                tmp_field=$((picked_field+1))
            fi
            data_type=$(sed -n 5p $ht_path | cut -d: -f$tmp_field)
            echo "data type is $data_type"
            echo "tmp field number is $tmp_field"
            echo "picked field number is $picked_field"
            read -p "What do you want to match for in column $select_col?: " match;
            read -p "What do you want to update in column $select_col?: " insert;
            if [ $data_type == 'int' ]
            then
                re='^[0-9]+$';
                if ! [[ $insert =~ $re ]] && [[ $match =~ $re ]]
                then
                   echo "Input is not an integer" >&2; 
                   exit
            fi

            
            # Sanitizes delimiter for all REGEX character by escaping them
            escaped_delm=$(echo $curr_delim | sed 's/[^^\\]/[&]/g; s/\^/\\^/g; s/\\/\\\\/g')
            awk -F"$escaped_delm" -v pick=$p_tmp_field -v a_del="$match" -v a_ins="$insert" -v OFS="$curr_delim" '$pick==a_del {$pick=a_ins} 1' $t_path > tmp && mv tmp $t_path

            # USE PRINTF to replace MULTICHAR DELIM LIKE FROM INSERT RECORD 
            #can be used for delete later, still needs work            # sed "s/\^\_\^/:/g" $t_path | cut -d: -f1 | grep -nw $delete | sed "s/\^\_\^/:/g" | cut -d: -f1 # to find line numbers to update
            # grep -w $delete $t_path | sed "s/\^\_\^/:/g" | cut -d: -f1 # field to update in line, 
            # how to deal with multiple character delim? could convert ^_^ to : briefly
            # where a condition is matched by grep, cut the field and update it
    esac
done