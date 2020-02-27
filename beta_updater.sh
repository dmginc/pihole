#!/bin/bash
#Whitelist Maintenance
#Backup old whitelist
/usr/bin/sqlite3 /etc/pihole/gravity.db "SELECT domain FROM domainlist" > /tmp/whitelist.bak;

#Delete old whitelist table contents
/usr/bin/sqlite3 /etc/pihole/gravity.db "DELETE FROM domainlist";

#Import new whitelist domains
for whitedomain in `cat /root/whitelist_test`
do
id=$((id+1))
/usr/bin/sqlite3 /etc/pihole/gravity.db "INSERT INTO domainlist VALUES ($id, 0, '$whitedomain', 1, date('now'), date ('now'), '');"
done

#Output total in new whitelist
echo `sqlite3 /etc/pihole/gravity.db "SELECT domain FROM domainlist WHERE type = 0;" | wc -l` "domains in new whitelist"

#Adlist Maintenance
#Backup old adlist domains
/usr/bin/sqlite3 /etc/pihole/gravity.db "SELECT address FROM adlist" > /tmp/adlist.bak;

#Delete old adlist table contents
/usr/bin/sqlite3 /etc/pihole/gravity.db "DELETE FROM adlist;"

#Delete old list data
/bin/rm -rf /etc/pihole/list.*

#Import new adlists
for i in `cat /root/adlist_test`
do
id=$((id+1))
/usr/bin/sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist VALUES ($id, '$i', 1, date('now'), date('now'), '');"
done

#Reload PiHole
/usr/local/bin/pihole -g
