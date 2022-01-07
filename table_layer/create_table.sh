#!/bin/bash

cd $1


while true
do
  echo -e "Table Name: \c"
  read tableName
  if [[ -f "$tableName".SQL ]]; 
  then
  echo "Table already existed ,choose another name"
  else 
  break
  fi
 done

  PS3="Table Creation Action:"
  echo -e "Number of Columns: \c"
  read colsNum
  counter=1
  sep=":"
  m_sep="^_^"
  flag=0
  echo "Do you want add primary key?"
  select approve in "yes" "no"
  do 
  case $approve in
    yes ) p_key="1"
          colType="pk";
          type=$type${colType}$sep;
          flag=1;
          break;;
    no )  p_key="0";break ;;
    * ) 
      echo "Invalid Choice" 
    ;;
    esac 
  done

  while [ $counter -le $colsNum ]
  do
    echo -e "Name of Column No.$counter: \c"
    read colName

    echo -e "Type of Column $colName: "

    select var in "int" "str"
    do
      case $var in
        int ) colType="int";type=$type${colType}$sep;tab=$tab${colType}$m_sep;break;;
        str ) colType="str";type=$type${colType}$sep;tab=$tab${colType}$m_sep;break;;
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
  # if [flag -eq 1] then temp="pk:$temp" fi -----------> here
  Metadata="m_sep:$m_sep\nindex:1\ncol_names:$temp\np_key:$p_key\ndata_types:${type::-1}" #removing last m_sepater
  
  # tab = "${tab::-1}" --------------> here to fix delete script (add first row -sep)
  touch .$tableName.SQL
  echo -e $Metadata  >> ".$tableName.SQL"
  touch $tableName.SQL
  echo -e $tab >> "$tableName.SQL"
  if [[ $? == 0 ]]
  then
    echo "Table Created Successfully"
    exit
  else
    echo "Error Creating Table $tableName"
    exit
  fi