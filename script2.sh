#!/bin/bash

echo "CPU AND MEMORY RESOURCES ------------------------------"

LOAD="$(uptime | grep -o "average:.*" | sed -n 's/average://p'  )"
FREE="$(free -m | grep "Mem" | tr -s ' ' | cut -d ' ' -f4)" 

echo "CPU Load Average:$LOAD      Free RAM: $FREE MB" 
echo $'\n'
echo "NETWORK CONNECTIONS -----------------------------------"

TRIM_FILE="$(cat /proc/net/dev | tr -s ' ')"
LO_RECEIVE="$( grep -o 'lo.*' <<< $TRIM_FILE | cut -d " " -f2)"
LO_TRANSMIT="$( grep -o 'lo.*' <<< $TRIM_FILE | cut -d " " -f3)"
ENP_RECEIVE="$(grep -o 'enp0s3.*' <<< $TRIM_FILE | cut -d " " -f2)"
ENP_TRANSMIT="$(grep -o 'enp0s3.*' <<< $TRIM_FILE | cut -d " " -f3)" 

echo "lo Bytes Received: $LO_RECEIVE       Bytes Transmitted: $LO_TRANSMIT"
echo "enp0s3 Bytes Received: $ENP_RECEIVE      Bytes Transmitted: $ENP_TRANSMIT"

if ping -c 1 google.com &> /dev/null
then
	echo "Internet Connectivity: Yes"	
else
	echo "Internet Connectivity: No"
fi

echo $'\n'
echo "ACCOUNT INFORMATION -----------------------------------"

TOTAL_USERS="$(cat /etc/passwd | wc -l)"
ACTIVE_USERS="$( uptime | tr -d " " | cut -d ',' -f2 | head -c1)"
CURRENT_USER="$(who | cut -d " " -f1)"
SHELL="$(cat /etc/passwd | grep $CURRENT_USER | rev | cut -d ":" -f1 | rev)" 

echo "Total Users:    $TOTAL_USERS   Number Active: $ACTIVE_USERS"
echo "Most Frequently Used Shell: $SHELL"
