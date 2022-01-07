#!/bin/bash
PS3="Action: "
t_path="$1/$2"
ht_path="$1/.$2"

curr_delim=$(head -n1 $ht_path | cut -d: -f2) # provides current delimeter from metadata
escaped_delm=$(echo $curr_delim | sed 's/[^^\\]/[&]/g; s/\^/\\^/g; s/\\/\\\\/g') # delimiter sanitized from regex chars
# $t_path  > tmp1

if [[ -f $t_path ]]; 
    then
	awk -F"$escaped_delm" -v OFS="$escaped_delm" '{if(NR==1){print $0}}' $t_path;
	read -p "Enter column to delete record from: " colName;
	read -p "Enter value : " Value;
	str=\'$Value\'
	echo $str
	awk -F"$escaped_delm" -v OFS="$escaped_delm" '
	{
		if(NR==1){
			for(i=1;i<=NF;i++){
				if($i=="'$colName'"){here=i;}
			}
		}
		else{
			if($here=='$Value' || $here==$str ){
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

# $t_path > tmp2
# if  cmp -s "$tmp1" "$tmp2"
# then 
# echo "The record deleted successfully"
# else
# echo "This record cannot be found"
# fi

