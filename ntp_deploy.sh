#!/bin/bash

sudo apt update
sudo apt install ntp -y

#The config files for ntp is in /etc/ntp.conf
#Changing the Servers time to our geo location

sed -i "s/pool 0.ubuntu.pool.ntp.org/pool ua.pool.ntp.org/g" /etc/ntp.conf

#Restart the service.
sudo service ntp restart

#crontab -e

croncmd="$(pwd)/ntp_verify.sh"
cronjob="*/1 * * * *   root  $croncmd >> $(pwd)/test.log 2>&1"

( crontab -l | grep -v -F "$croncmd" ; echo "$cronjob" ) | crontab -

