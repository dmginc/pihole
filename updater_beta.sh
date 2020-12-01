#Updater v1.0

#!/bin/bash
timestamp=`date '+%Y%m%d%H%M%S'`;

#Whitelist Maintenance
#Backup old whitelist
/usr/bin/sqlite3 /etc/pihole/gravity.db "SELECT domain FROM domainlist" > /tmp/whitelist.bak.$timestamp;

#Delete old whitelist table contents
/usr/bin/sqlite3 /etc/pihole/gravity.db "DELETE FROM domainlist";

#Import new whitelist domains
for domain in `curl -sS https://raw.githubusercontent.com/dmginc/pihole/master/whitelist.txt`
do
id=$((id+1))
	/usr/bin/sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO domainlist VALUES ($id, 0, '$domain', 1, date('now'), date ('now'), '');"
done

#Output total in new whitelist
echo `sqlite3 /etc/pihole/gravity.db "SELECT COUNT(domain) FROM domainlist WHERE type = 0;"` "domains in new whitelist"

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
	/usr/bin/sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist VALUES ($id, '$address', 1, date('now'), date('now'), '');"
done

#Reload PiHole
/usr/local/bin/pihole -g