xen_domain_backup_script
========================

Scripts for backuping xen domains

Take domain from cfg file, pause it, dd it to img, resume it

-------------------------

RELEASE 0.1.0

It is actually working ^^

1. You give it backup location, domain name and domain image location (or lvm partition)
2. It parses cfg file you provide
3. It pauses domain
4. It dd it to backup location
5. It unpause domain
6. It logs some information with timestamps

NOT GOOD NOR WORKING:

1. No checks whether domain exists, already paused, etc..
2. No checks whether paths are correct
3. No error handle
4. Not pretty configuration file
5. No failure looging

Going to release 0.2.0 soon :))
*need to decide how name releases and what incremention to numbers apply

-------------------------

RELEASE 0.1.1

1. Added datestamp to backup
2. Now script exit with 0
3. Error messages writing to log file