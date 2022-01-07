#!/bin/bash
PS3="Action: "
t_path="$1/$2"
ht_path="$1/.$2"

curr_delim=$(head -n1 $ht_path | cut -d: -f2) # provides current delimeter from metadata
escaped_delm=$(echo $curr_delim | sed 's/[^^\\]/[&]/g; s/\^/\\^/g; s/\\/\\\\/g') # delimiter sanitized from regex chars

# cp $t_path tmp1 

if [[ -f $t_path ]]; 
    then
	awk -F"$escaped_delm" -v OFS="$escaped_delm" '{if(NR==1){print $0}}' $t_path; # Prompt the name of fields
	read -p "Enter column to delete record from: " colName; # Picking which field
	read -p "Enter value : " Value; # Picking which value
	str=\'$Value\' # Regex for string values
	awk -F"$escaped_delm" -v OFS="$escaped_delm" '
	{
		if(NR==1){
			for(i=1;i<=NF;i++){
				if($i=="'$colName'"){here=i;}
			}
		}
		else{
			if($here=='$Value' || $here=="'$str'"){
				target=NR
			}
		}
		{if(NR!=target)print 
		}
	}' $t_path > tmp && mv tmp $t_path; # Deleting by moving the data without the records where had to be deleted
else
	echo "Worng Pick" # reference to table name not table path
	exit
fi

# cp $t_path tmp2
# check=$(cmp -s "$tmp1" "$tmp2"cmp -s ")
# if [ -z $($check)]

#    echo "Record deleted successfully"
# else
#    echo "Record not found"
# fi

# rm tmp1 tmp2
