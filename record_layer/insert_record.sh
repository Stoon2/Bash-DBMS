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
    t_path="$1/$2"
    ht_path="$1/.$2"
    total_cols=$(tail -n1 $ht_path | grep -o ":" | wc -l) # provides num of cols from metadata
    curr_delim=$(head -n1 $ht_path | cut -d: -f2) # provides current delimeter from metadata

fi

# echo "Do you wish to specify a primary key?";

# select p_key in "Yes" "No"
# do
#     case $p_key in
#         "Yes") 
#             total_cols=$((total_cols+1));
#             break
#         ;;
#         "No") 
#             echo "No primary key will be specified"
#             break
#         ;;
#         *) 
#             echo "Invalid option"
#         ;;
#     esac
# done

r_enteries=() # array to store user input
for ((i=1; i<=$total_cols; i++))
do
    # logic created to check correct column data-type
    tmp=$i;
    tmp=$((i+1));
    col_name=$(sed -n 3p $ht_path | cut -d: -f$tmp)

    # if column value is string, wrap input in single quotes to make it literal
    if [ [$(tail -n1 $ht_path | cut -d: -f$tmp) == 'pk' ]
    then
        echo im a pk
    elif [ $(tail -n1 $ht_path | cut -d: -f$tmp) == 'str' ]
    then
        read -p "Please enter a string for column $col_name: ";
        r_enteries+=( "'$REPLY'" )
    
    elif [ $(tail -n1 $ht_path | cut -d: -f$tmp) == 'int' ]
    then
        read -p "Please enter an integer for column $col_name: ";
        # Checks if input is an integer
        re='^[0-9]+$';
        if ! [[ $REPLY =~ $re ]]
        then
           echo "Input is not an integer" >&2; 
           exit 1
        else
            r_enteries+=( $REPLY )
        fi
    fi
done

# increment index for table
if [ $(sed -n 4p $ht_path | cut -d: -f2) == 1 ]
then
    o_index=`sed -n 2p $ht_path | cut -d: -f2`
    n_index=`expr $o_index + 1`
    sed -i "s/index:$o_index/index:$n_index/g" $ht_path
fi

# INSURE WE ADD ESCAPE SQUENCE TO BACKSPACE '\'
# add delimiter after every column
printf -v joined "%s${curr_delim}" "${r_enteries[@]}"
# inputs string delimited by curr_delim and removes the delim from end of line
echo "${joined::-${#curr_delim}}" >> $t_path
