  #!/bin/bash

  echo -e "Enter Current Database Name: \c"
  read db_name
  echo -e "Enter New Database Name: \c"
  read new_name
  mv db_collection/$db_name db_collection/$new_name 2>/dev/null
  if [[ $? == 0 ]]; then
    echo "Database Renamed Successfully to $new_name"
    exit
  else
    echo "Error Renaming Database"
    exit
  fi
  