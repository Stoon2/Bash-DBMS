#!/bin/bash
PS3="Choice:"
cd $1

while true
do
  echo -e "Table Name: \c"
  read tableName
  if [[ -f $tableName ]]; 
  then
  echo "Table already existed ,choose another name"
  else 
  break
  fi
 done


  echo -e "Number of Columns: \c"
  read colsNum
  counter=1
  sep=":"
  while [ $counter -le $colsNum ]
  do
    echo -e "Name of Column No.$counter: \c"
    read colName

    echo -e "Type of Column $colName: "
    select var in "int" "str"
    do
      case $var in
        int ) colType="int";type=$type${colType}$sep;break;;
        str ) colType="str";type=$type${colType}$sep;break;;
        * ) echo "Invalid Choice" ;;
      esac
    done
    if [[ $counter == $colsNum ]]; then
      temp=$temp$colName
    else
      temp=$temp$colName$sep
    fi
    ((counter++))
  done
  echo "Do you want add primary key?"
  select approve in "yes" "no"
  do 
  case $approve in
        yes ) p_key="1";break ;;
        no ) p_key="0";break ;;
        * ) echo "Invalid Choice" ;;
        esac 
    done
  structure="delim:^_^\nindex:1\ncol_names:$temp\np_key:$p_key\ndata_types:${type::-1}" #removing last delimater
  touch .$tableName
  echo -e $structure  >> ".$tableName"
  touch $tableName
  #echo -e $temp >> "$tableName"
  if [[ $? == 0 ]]
  then
    echo "Table Created Successfully"
    exit
  else
    echo "Error Creating Table $tableName"
    exit
  fi