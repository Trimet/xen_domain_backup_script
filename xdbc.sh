#!/bin/bash

conf_file="xdbc.cfg";


cat $conf_file | while read line 
do
# for line in "`cat $conf_file`" ; do
	is_commented="`expr index "$line" '#'`";
	has_equal_sign="`expr index "$line" '='`";
	log_file_name="test";
	# echo $is_commented;
	# echo "${#line}";
	if [ "$is_commented" != 1 -a "${#line}" != 0 ]; then
		if [ "$has_equal_sign" != 0 -a "`expr substr "$line" 1 "$(($has_equal_sign-1))"`" = "backup_path" ]; then
			# echo "${line:0:"$has_equal_sign"}";

			backup_path=`expr substr "$line" "$(($has_equal_sign+1))" "${#line}"`;
			
			echo "##########################################" >> "$backup_path/$log_file_name";

			log_message="Backup script started";
			echo "["`date +%d.%m.%y\ %T`"] >>" "$log_message" >> "$backup_path/$log_file_name";
			
			# echo `date +%d.%m.%y\ %T`;
			# echo "$index";
			# echo `expr substr "$line" 1 "$(($has_equal_sign-1))"`;
		fi

		if [ "$line" = "[Domains]" ]; then
			echo "В этой строке определено начало перечисления доменов";

		fi

		has_delimeter="`expr index "$line" ';'`";

		if [ "$has_delimeter" != 0 ]; then
			domain_name="`expr substr "$line" 1 "$(($has_delimeter-1))"`"
			domain_path="`expr substr "$line" "$(($has_delimeter+1))" "${#line}"`"

			echo "------------------------------------------" >> "$backup_path/$log_file_name";

			log_message="DD of <<$domain_name>> image started";
		
			echo "["`date +%d.%m.%y\ %T`"] >>" "$log_message" >> "$backup_path/$log_file_name";
			
			dd if="$domain_path" of="$backup_path/$domain_name.backup" bs=512M;

			log_message="DD of <<$domain_name>> image ended";

			echo "["`date +%d.%m.%y\ %T`"] >>" "$log_message" >> "$backup_path/$log_file_name";
		fi
		
		#if `$line | grep "Domain"`

		echo "$line";
	fi
	
done

echo $log_file_name;

echo "------------------------------------------" >> "$backup_path/$log_file_name";

log_message="Backup finished";
echo "["`date +%d.%m.%y\ %T`"] >>" "$log_message" >> "$backup_path/$log_file_name";
