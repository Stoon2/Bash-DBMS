#!/bin/bash

  tput setaf 2
  echo  --------------------------------------------
  tput setaf 11
  echo -e " ------------------ $(tput setaf 1) Connected" #Connect here to Database name(Directory name)
  tput setaf 2
  echo  --------------------------------------------
  tput setaf 2
  echo  "1. List Existing Tables"  
  echo  "2. Create New Table"           
  echo  "3. Drop Table"          
  echo  "4. Insert Into Table"          
  echo  "5. Select From Table"               
  echo  "6. Delete From Table"          
  echo  "7. Update Table"                 
  echo  "8. Back To Main Menu"
  echo  "9. Exit"                       
  echo -e "Table Action: \c"
  read pick
  case $pick in
    1)  ls db_collection;;
    2)  bash table_layer/create_table.sh ;;
    3)  bash table_layer/drop_table.sh ;;
    4)  bash record_layer/insert_record.sh ;;
    5)  bash record_layer/select_record.sh ;;
    6)  bash record_layer/delete_record.sh ;;
    7)  bash record_layer/update_record.sh ;;
    8)  bash main.sh ;;
    9)  exit ;;
    *)  echo "$(tput setaf 1)Invalid Input";;
  esac
  
  