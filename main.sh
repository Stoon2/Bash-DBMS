#!/bin/bash
PS3="Menu Action:"
mkdir -p db_collection # insure db_collection folder is always available
find ~+ -type f,d | xargs chmod a+x # give permission  to all files and dirs in the project

tput setaf 10 #Matrix color
# Later we can edit the $USER to force capitalization on first letter and lower on the rest of username.
# this will do for now though.
echo ---------------------------------------------------------------------------
echo
echo "                Welcome ${USER^} to Bash-DBMS System 🥳"
echo "                 Developed by: M.Elsayed and M.Mohy"
echo
echo ---------------------------------------------------------------------------

tput setaf 2
echo Please choose an action:
curr_db="\0" # equal to nothing
select db_input in "Create DB" "List DBs" "Select DB" "Drop DB" "Rename DB" "Exit DBMS"
do
    case $db_input in
    "Create DB" )
        echo Enter DB name:
        read
        db_layer/create_db.sh $REPLY
    ;;
    "List DBs" )
        db_layer/list_db.sh 
    ;;
    "Select DB" )
        curr_db=$(db_layer/select_db.sh $REPLY)
        echo Database selected is: $curr_db

        select t_choice in "List Existing Tables" "Create New Table" "Drop Table" "Insert Into Table" "Select From Table" "Delete From Table" "Update Table" "Back To Main Menu" "Exit"
        do
          case $t_choice in
            "List Existing Tables" )  
              ls $curr_db;
            ;;
            "Create New Table" )  
              bash table_layer/create_table.sh
            ;;
            "Drop Table" )  
              bash table_layer/drop_table.sh
            ;;
            "Insert Into Table" )
              bash record_layer/insert_record.sh
            ;;
            "Select From Table" )
              bash record_layer/select_record.sh
            ;;
            "Delete From Table" )
              bash record_layer/delete_record.sh
            ;;
            "Update Table" )
              bash record_layer/update_record.sh
            ;;
            "Back To Main Menu" )
              break
            ;;
            "Exit" )  
              exit 
            ;;
            * )
              echo "$(tput setaf 1)Invalid Input"
          esac
        done
    ;;
    "Drop DB" )
        db_layer/drop_db.sh 
    ;;
    "Rename DB" )
        db_layer/rename_db.sh
    ;;
    "Exit DBMS" )
        exit
    ;;
    * )
        echo Not valid input, please choose a number from the menu.
    esac
done

