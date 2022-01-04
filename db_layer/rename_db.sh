  #!/bin/bash
# note for change:
# Lets insure that the $curr_db variable in main is nulled after a rename to avoid possible conflicts with renaming
#add validation if database is exist
#add no databases when dir is empaty
  echo -e "Enter Current Database Name: \c"
  read db_name
  echo -e "Enter New Database Name: \c"
  read db_new_name
  mv db_collection/$db_name db_collection/$db_new_name 2>/dev/null
  if [[ $? == 0 ]]; then
    echo "Database Renamed Successfully to $db_new_name"
    exit
  else
    echo "Error Renaming Database"
    exit
  fi
  