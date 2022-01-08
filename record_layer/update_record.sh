#!/bin/bash
PS3="Action:"
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
    pk_exists=0;
    if [ $(sed -n 4p "$ht_path" | cut -d: -f2) == 1 ]
    then
        pk_exists=1
        total_cols=$(($total_cols-1))
    fi
fi

sel_list=$(sed -n 3p $ht_path); # select third row of hidden table
sel_list=${sel_list:10}; # remove col_names from hidden file output
echo # spacing
echo "Which column to match for?";
select select_col in $(echo $sel_list | sed 's/:/ /g') "Exit"
do
    case $select_col in
        "Exit" )
            exit
        ;;
        # Matches column name with column type, while compensating for lack of PK in col_names
        "$select_col" )
            picked_field=0;
            for ((i=1; i<=$total_cols; i++))
            do
                if [ "$(echo $sel_list | cut -d: -f$i)" == "$select_col" ]
                then
                    picked_field=$i
                    break
                fi
            done

            # Where X column Y update to Z
            echo "Which column to update in matched record?";
            update_field=0;
            select s_update_col in $(echo $sel_list | sed 's/:/ /g') "Exit"
            do
                case $s_update_col in
                    "Exit" )
                        exit
                    ;;
                    "$s_update_col" )
                        for ((i=1; i<=$total_cols; i++))
                        do
                            if [ "$(echo $sel_list | cut -d: -f$i)" == "$s_update_col" ]
                            then
                                update_field=$i
                                echo $update_field
                                break
                            fi
                        done
                        break
                    esac
            done
            
            # Checks if Primary Key exists, if so increment picked fields by 1 to compensate col names
            # p_tmp_field added as hot-fix
            if [ $pk_exists == 1 ];
            then
                tmp_field=$((picked_field+2));   
                p_tmp_field=$((picked_field+1));
                update_field=$((update_field+1));
                update_tmp_field=$((update_field+1));
            else
                tmp_field=$((picked_field+1));
                update_tmp_field=$((update_field+1));
                p_tmp_field=$((picked_field));
            fi
            
            # Spacing for menu
            echo
            
            data_type=$(sed -n 5p $ht_path | cut -d: -f$tmp_field);
            col_data_type=$(sed -n 5p $ht_path | cut -d: -f$update_tmp_field);
            
            # Validation to insure str input by user is always surrounded by single quotes like so 'example'
            if [ $col_data_type == 'str' ]
            then
                read -p "What do you want to match for in column $select_col?: " match;
                read -p "What do you want to insert in column $s_update_col?: " insert;
                if [ $data_type == 'str' ]
                then
                    match="'$match'"
                fi
                insert="'$insert'"
            else
                read -p "What do you want to match for in column $select_col?: " match;
                read -p "What do you want to insert in column $s_update_col?: " insert;
                if [ $data_type == 'str' ]
                then
                    match="'$match'"
                fi
            fi

            # Validation for user input in case its not an integer when it's supposed to be
            re='^[0-9]+$';
            if [ $data_type == 'int' ] 
            then
                if ! [[ $match =~ $re ]]
                then
                   echo "Input is not an integer" >&2;
                   exit
                fi
            fi

            if [ $col_data_type == 'int' ]
            then
                if ! [[ $insert =~ $re ]]
                then
                    echo "Input is not an integer" >&2;
                    exit
                fi
            fi

            # Sanitizes delimiter for all REGEX character by escaping them
            escaped_delm=$(echo $curr_delim | sed 's/[^^\\]/[&]/g; s/\^/\\^/g; s/\\/\\\\/g')
            awk -F"$escaped_delm" -v a_col_update=$update_field -v pick=$p_tmp_field -v a_del="$match" -v a_ins="$insert" -v OFS="$curr_delim" '$pick==a_del {$a_col_update=a_ins} 1' $t_path > tmp && mv tmp $t_path
    esac
done