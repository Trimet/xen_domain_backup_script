#!/bin/bash

conf_file="xdbc.cfg";

cat $conf_file | while read line 
do
# for line in "`cat $conf_file`" ; do
	is_commented="`expr index "$line" '#'`";
	has_equal_sign="`expr index "$line" '='`";
	# echo $is_commented;
	# echo "${#line}";
	if [ "$is_commented" != 1 -a "${#line}" != 0 ]; then
		if [ "$has_equal_sign" != 0 -a "`expr substr "$line" 1 "$(($has_equal_sign-1))"`" = "backup_path" ]; then
			# echo "${line:0:"$has_equal_sign"}";

			backup_path=`expr substr "$line" "$(($has_equal_sign+1))" "${#line}"`;
			

			touch "$backup_path/test";
			
			# echo "$index";
			# echo `expr substr "$line" 1 "$(($has_equal_sign-1))"`;
		fi

		if [ "$line" = "[Domains]" ]; then
			echo "В этой строке определено начало перечисления доменов";
		fi
		
		#if `$line | grep "Domain"`

		echo "$line";
	fi
	
done

