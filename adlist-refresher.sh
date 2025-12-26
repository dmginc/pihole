#!/bin/bash

#Adlist Maintenance
#Backup old adlist domains
/usr/bin/sqlite3 /etc/pihole/gravity.db "SELECT address FROM adlist" > /tmp/adlist.bak.$timestamp;

#Delete old adlist table contents
/usr/bin/sqlite3 /etc/pihole/gravity.db "DELETE FROM adlist;"

#Delete old list data
/bin/rm -rf /etc/pihole/list.*

#Import new adlists
for address in `curl -sS https://raw.githubusercontent.com/dmginc/pihole/master/adlists.list | grep -v "#"`
do
id=$((id+1))
/usr/bin/sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist VALUES ($id, '$address', 1, date('now'), date('now'), '', date('now'), '', '', '', '', '');"
done

#Reload PiHole
/usr/local/bin/pihole -g
