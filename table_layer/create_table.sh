#!/bin/bash
cd $1
while true
do
  echo -e "Table Name: \c"
  read tableName
  if [[ -f "$tableName".SQL ]]; #Validation to check existing tables first
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

  echo "Do you want add primary key?" #P_Key??
  select approve in "yes" "no"
  do 
  case $approve in
    yes ) p_key="1"
          colType="pk";
          type=$type${colType}$sep; #Metadata 
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
    echo -e "Type of Column $colName: \c"

    select var in "int" "str"
    do
      case $var in
        int ) colType="int";type=$type${colType}$sep;tab=$tab${colType}$m_sep;break;; #Metadata 
        str ) colType="str";type=$type${colType}$sep;tab=$tab${colType}$m_sep;break;; #Metadata
        * ) echo "Invalid Choice" ;;
      esac
    done
    if [[ $counter == $colsNum ]]; 
    then
      temp=$temp$colName #Metadata
    else
      temp=$temp$colName$sep #Metadata
    fi
    ((counter++))
  done
  
  if [flag -eq 1] then temp='pk:$temp' fi #Metadata 

  Metadata="m_sep:$m_sep\nindex:1\ncol_names:$temp\np_key:$p_key\ndata_types:${type::-1}" #Assigning the Metadata key, and removing last separator
  
  #Creating table for data and hidden table for metadata
  # tab = "${tab::-1}"
  touch .$tableName.SQL
  echo -e $Metadata  >> ".$tableName.SQL"
  touch $tableName.SQL
  echo -e $tab >> "$tableName.SQL"

  if [[ $? == 0 ]] #Validation of creation
  then
    echo "Table Created Successfully"
    exit
  else
    echo "Error Creating Table $tableName"
    exit
  fi