#!/bin/bash


conf_file="xdbc.cfg";
backup_path="";
log_file_name="xdbc.log";

delimeter_string1="################################################################################"
delimeter_string2="--------------------------------------------------------------------------------"

while read line
do
    is_commented="`expr index "$line" '#'`";
    has_equal_sign="`expr index "$line" '='`";

    if [ "$is_commented" != 1 -a "${#line}" != 0 ]; then
        if [ "$has_equal_sign" != 0 -a "`expr substr "$line" 1 "$(($has_equal_sign-1))"`" = "backup_path" ]; then

            backup_path="`expr substr "$line" "$(($has_equal_sign+1))" "${#line}"`";

            echo "$delimeter_string1" >> "$backup_path/$log_file_name";

            log_message="Backup script started";
            echo "["`date +%d.%m.%y\ %T`"] >>" "$log_message" >> "$backup_path/$log_file_name";
        fi

        if [ "$line" = "[Domains]" ]; then
            echo "Saving domains";
        fi

        has_delimeter="`expr index "$line" ';'`";

        if [ "$has_delimeter" != 0 ]; then
            domain_name="`expr substr "$line" 1 "$(($has_delimeter-1))"`"
            domain_path="`expr substr "$line" "$(($has_delimeter+1))" "${#line}"`"

            xm pause "$domain_name" 2>>"$backup_path/$log_file_name";

            echo "$delimeter_string2" >> "$backup_path/$log_file_name";

            log_message="DD of <$domain_name> image started";
            echo "["`date +%d.%m.%y\ %T`"] >>" "$log_message" >> "$backup_path/$log_file_name";

            dd if="$domain_path" of="$backup_path/$domain_name.[`date +%d.%m.%y`].backup" bs=256M 2>>"$backup_path/$log_file_name";

            log_message="DD of <$domain_name> image ended";
            echo "["`date +%d.%m.%y\ %T`"] >>" "$log_message" >> "$backup_path/$log_file_name";

            xm unpause "$domain_name" 2>>"$backup_path/$log_file_name";
        fi
    fi
done < $conf_file

echo "$delimeter_string2" >> "$backup_path/$log_file_name";

log_message="Backup finished";
echo "["`date +%d.%m.%y\ %T`"] >>" "$log_message" >> "$backup_path/$log_file_name";


exit 0