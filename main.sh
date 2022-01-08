#!/bin/bash
PS3="Main Action:"
# shopt -s expand_aliases;
mkdir -p db_collection # insure db_collection folder is always available
find ~+ -type f,d | xargs chmod a+x # give permission  to all files and dirs in the project

tput setaf 10 #Matrix color
# tput blink
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
      echo -e "Enter DB name: \c"
      read
      db_layer/create_db.sh $REPLY
      ;;
    "List DBs" )
      db_layer/list_db.sh 
      ;;
    "Select DB" )
      curr_db=$(db_layer/select_db.sh $REPLY)
      echo Database selected is: "$(tput setaf 1)$(tput blink) $curr_db $(tput sgr0)"
      select t_choice in "List Existing Tables" "Create New Table" "Drop Table" "Insert Into Table" "Select From Table" "Delete From Table" "Update Table" "Back To Main Menu" "Exit"
      do
      PS3="Table Action:" 
    case $t_choice in
    "List Existing Tables" )  
      bash table_layer/list_tables.sh $curr_db
      ;;
    "Create New Table" )  
      bash table_layer/create_table.sh $curr_db
      ;;
    "Drop Table" )  
      bash table_layer/drop_table.sh $curr_db
      ;;
    "Insert Into Table" )
      select select_table in $(ls $curr_db)
      do
        record_layer/insert_record.sh $curr_db $select_table
        break
      done
      ;;
    "Select From Table" )
      select select_table in $(ls $curr_db)
      do
        record_layer/select_record.sh $curr_db $select_table
        break
      done
      ;;
    "Delete From Table" )
      echo Pick a table: 
      select select_table in $(ls $curr_db)
      do
        record_layer/delete_record.sh $curr_db $select_table
        break
      done
      ;;
    "Update Table" )
      select select_table in $(ls $curr_db)
      do
        record_layer/update_record.sh $curr_db $select_table
        break
      done
      ;;
    "Back To Main Menu" )
      PS3="Main Action:"
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
        echo "Not valid input, please choose a number from the menu."
    esac
done

