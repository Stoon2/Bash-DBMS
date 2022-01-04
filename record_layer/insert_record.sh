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
if [ ! -d "$(pwd)/db_collection" ]
then
    echo "db_collection directory does not exist, please create a DB through 'Create a DB' in the main menu."
    exit
# assumes curr_db and curr_table are passed to script, check if they exist
elif [ ! "$(ls -A $DIR/$1 2>/dev/null)" ] 
then
    echo No $1 database exists, please create a database.
    exit
elif [ ! "$(ls -A $DIR/$1/$2 2>/dev/null)" ] 
then
    echo No $2 table exists, please create a table.
    exit
else
    total_cols=$(tail -n1 db_collection/test/.t1 | grep -o ":" | wc -l) # provides num of cols from metadata
    curr_delim=$(head -n1 db_collection/test/.t1 | cut -d: -f2) # provides current delimeter from metadata
    echo total cols: $total_cols
    echo current delimeter: $curr_delim
fi

echo "Do you wish to specify a primary key?";

select p_key in "Yes" "No"
do
    case $p_key in
        "Yes") 
            total_cols=$((total_cols+1));
            break
        ;;
        "No") 
            echo "No primary key will be specified"
            break
        ;;
        *) 
            echo "Invalid option"
        ;;
    esac
done

r_enteries=() # array to store user input
for ((i=1; i<=$total_cols; i++))
do
    # logic created to check correct column data-type
    tmp=$i;
    tmp=$((i+1));

    # if column value is string, wrap input in single quotes to make it literal
    if [ $(tail -n1 $DIR/$1/.$2 | cut -d: -f$tmp) == 'str' ]
    then
        read -p "Please enter a string for column $i: ";
        r_enteries+=( "'$REPLY'" )
    elif [ $(tail -n1 $DIR/$1/.$2 | cut -d: -f$tmp) == 'int' ]
    then
        read -p "Please enter an integer for column $i: ";
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
echo ${r_enteries[1]}
# regex in sed escapes any string colons followed by ours
echo ${r_enteries[@]} 
printf -v joined "%s${curr_delim}" "${r_enteries[@]}"
echo "${joined%curr_delim}" >> $DIR/$1/$2
