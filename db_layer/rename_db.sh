  #!/bin/bash
  PS3="Choose:"
if [ ! "$(ls -A $(pwd)/db_collection/ 2>/dev/null)" ] #Validation Checking the existance of the DB
then
    echo "No databases to rename" #Empty NO DBs
    exit
else 
  echo -e "Enter Current Database Name: \c" 
  read db_name
  echo -e "Enter New Database Name: \c"
  read db_new_name 
  DIR="db_collection/$db_new_name"
  if [ -d "$DIR" ] #Validation for not renaming faulty
    then
    echo "The new name can't be processed, try another one"
  else
    mv db_collection/$db_name db_collection/$db_new_name 2>/dev/null
    if [[ $? == 0 ]]; then
      echo "Database Renamed Successfully to $db_new_name"
      exit
    else
      echo "Error Renaming Database, there is no Database named $db_name"
      exit
    fi
  fi
fi
  