#!/bin/bash
# This script checks if the ntp process is running, stops it, updates the system time, starts it again

ps cax | grep -c ntpd > /dev/null
onoff=$?
if [ "$onoff" -gt 0 ]; then
    echo "stopping ntpd..."
    service ntp stop
    echo "ntpd stopped"
else
    echo "ntpd not running, ready to update the date"
fi


isinstalled=$(dpkg-query -l | grep -c ntpdate)
if [ "$isinstalled" -gt 0 ]; then
    ntpdate -t 3 -s ntp4.stratum2.ru
    echo "date and time update executed"
else
    echo "ntpdate package not installed, can't update using ntp"
fi

echo "restarting ntpd..."
service ntp start 
echo "ntpd running"
echo "printing current date and time:"
date

exit

