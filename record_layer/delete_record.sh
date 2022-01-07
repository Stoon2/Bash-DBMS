#!/bin/bash
PS3="Action: "
t_path="$1/$2"
ht_path="$1/.$2"
curr_delim=$(head -n1 $ht_path | cut -d: -f2) # provides current delimeter from metadata
escaped_delm=$(echo $curr_delim | sed 's/[^^\\]/[&]/g; s/\^/\\^/g; s/\\/\\\\/g') # delimiter sanitized from regex chars
# cp $1 tmp1

if [[ -f $t_path ]]; 
    then
	awk -F"$escaped_delm" -v OFS="$escaped_delm" '{if(NR==1){print $0}}' $t_path;
	read -p "Enter column to delete record from: " colName;
	read -p "Enter value : " Value;
	str='((?:''|['$Value'^])*)'
	awk -F"$escaped_delm" -v OFS="$escaped_delm" '
	{
		if(NR==1){
			for(i=1;i<=NF;i++){
				if($i=="'$colName'"){here=i;}
			}
		}
		else{
			if($here=='$Value' || $here=='$Value'){
				target=NR
			}
		}
		{if(NR!=target)print 

		}
	}' $t_path > tmp && mv tmp $t_path;
	# sed -i ''$target'd' $t_path
	# echo $target
else
	echo "Worng Pick" # reference to table name not table path, leave as is
	exit
fi

# cp $1 tmp2
# if  [[ tmp1 != tmp2 ]];
# then 
# echo the record deleted successfully
# else
# echo this record cannot found
# fi
# rm tmp1,tmp2;

