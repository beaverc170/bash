#!/bin/sh
#v.01 - Created by Jim Parris
# Compile information
# Includes Jinja2 templates
## Get the IP of the default nic from Ansible Facts
ADDR=`/sbin/ifconfig {{ ansible_default_ipv4.interface }} | grep inet | awk '{print $2}' | sed -e s/.*://`
## Compile the FQDN
HOST=`hostname`
HOST=$HOST".dii.local."
# Begin the calls
# Init the call with a a single bracket
echo "server {{ dnsservers[Region]['pri'] }}" > /var/log/serverdns.log
# Delete the existing record
echo "update delete $HOST A" >> /var/log/nsupdates.log
# Create a new record 
echo "update add $HOST 3600 A $ADDR" >> /var/log/nsupdates.log
# SEND IT!
echo "send" >> /var/log/nsupdates.log
echo "quit" >> /var/log/nsupdates.log
