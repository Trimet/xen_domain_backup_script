#!/bin/bash

conf_file="xdbc.cfg.example";


for line in "`cat $conf_file`" ; do
	echo "$line";
done

