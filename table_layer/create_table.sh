#!/bin/bash

echo -e "Table Name: \c"
  read tablename
  if [[ -f $tablename ]]; then
    echo "table already existed ,choose another name"
  fi
