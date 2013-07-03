#!/bin/bash

conf_file="xdbc.cfg.example";

cat $conf_file | while read line 
do
# for line in "`cat $conf_file`" ; do
	is_commented="`expr index "$line" '#'`";
	# echo $is_commented;
	# echo "${#line}";
	if [ "$is_commented" != 1 -a "${#line}" != 0 ]; then
		echo `expr match "$line" 'Domains'`;
		#if `$line | grep "Domain"`

		echo "$line";
	fi
	
done

