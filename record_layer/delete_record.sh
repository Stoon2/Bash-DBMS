#!/bin/bash
PS3="Action: "
read -p "Enter table Name: " tableName
if [[ -f $1 ]]; 
    then
	awk -F: 'BEGIN{FS=":"}{if(NR==1){print $0}}' $1;
	read -p "Enter column to delete record from: " colName;
	read -p "Enter value : " Value;
	awk -F:  'BEGIN{FS=":"}
	{
		if(NR==1){
			for(i=1;i<=NF;i++){
				if($i=="'$colName'"){here=i}
			}
		}
		else{
			if($here=='$Value' || $here=='$Value'){
				target=NR
			}
		}
		{if(NR!=target)print 
		}
	}' $1 > tmp && mv tmp $1;
else
	echo "$1 doesn't exist";
    exit
fi