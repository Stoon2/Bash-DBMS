#!/bin/bash

select t_choice in "List Existing Tables" "Create New Table" "Drop Table" "Insert Into Table" "Select From Table" "Delete From Table" "Update Table" "Back To Main Menu" "Exit"
do
  case $t_choice in
    "List Existing Tables" )  
      ls $1;
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
      exit 2 # exits two layers of shells
    ;;
    "Exit" )  
      exit 
    ;;
    * )
      echo "$(tput setaf 1)Invalid Input"
  esac
done