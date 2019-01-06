#! /bin/bash
# This is a quick and shitty script, but it works.  So, there's that.

echo -e " \e[1m Downloading and merging whitelist now... \e[0m"
curl -sS https://raw.githubusercontent.com/dmginc/pihole/master/whitelist.txt > /etc/pihole/whitelist.txt
echo ' '
sleep 1
echo -e " \e[1m Hopefully that worked!  \e[0m"
echo ' '
sleep 1
echo -e " \e[1m Removing and cleaning up old blacklists..  \e[0m"
rm -rf /etc/pihole/list.*
echo ' '
sleep 1
echo -e " \e[1m Pulling new blacklists now...  \e[0m"
curl -sS https://raw.githubusercontent.com/dmginc/pihole/master/adlists.list > /etc/pihole/adlists.list
echo ' '
sleep 1
echo -e " \e[1m Again, hopefully that worked.  This script has 0 error catching abilities.  \e[0m"
echo ' '
sleep 1
echo -e " \e[1m Restarting PiHole's DNS server to pick-up new whitelist.  \e[0m"
sleep 2
/usr/local/bin/pihole restartdns
echo ' '
sleep 1
echo -e " \e[1m Parsing new blacklists... \e[0m"
sleep 2
echo ' '
/usr/local/bin/pihole -g
