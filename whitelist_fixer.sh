#Version 1.0

sort -u /etc/pihole/whitelist.txt > /tmp/whitelist_temp
cat /tmp/whitelist_temp > /etc/pihole/whitelist.txt
rm -rf /tmp/whitelist_temp
