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
  if [ -z "${colsNum##*[!0-9]*}" ]  #Validation to add only numbers to columans
  then
  echo "Error, Enter a number"; exit;
  else

  counter=1 #Counter for columans data's input loop
  sep=":" #Metadata separator
  m_sep="^_^" #Table separator
  trig="0" #Flag for creating primary key

  echo "Do you want add primary key?" #Asking for adding primary key
  select approve in "yes" "no"
  do 
  case $approve in
    yes ) p_key="1"
          colType="pk";
          type=$type${colType}$sep; #Metadata 
          trig="1";
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

  tab="${tab::-${#m_sep}}" 

  p1="pk$m_sep"
  p2="$tab"
  if [ $trig == "1" ]
  then
  p_ki="$p1$p2" #Metadata if there is a primary key
  fi 

  Metadata="m_sep:$m_sep\nindex:1\ncol_names:$temp\np_key:$p_key\ndata_types:${type::-1}" #Assigning the Metadata key, and removing last separator
  
  #Creating table for data and hidden table for metadata
  # tab = "${tab::-1}" --------------> here
  touch .$tableName.SQL
  echo -e $Metadata  >> ".$tableName.SQL"
  touch $tableName.SQL
  if [ $trig == "1" ]
  then
  echo -e $p_ki >> "$tableName.SQL"
  else
  echo -e $tab >> "$tableName.SQL"
  fi

  if [[ $? == 0 ]] #Validation of creation
  then
    echo "Table Created Successfully"
    exit
  else
    echo "Error Creating Table $tableName"
    exit
  fi
  fi