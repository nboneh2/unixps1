#!/bin/bash

echo "CPU AND MEMORY RESOURCES ------------------------------"

LOAD="$(uptime | grep -o "average:.*" | sed -n 's/average://p'  )"
FREE="$(free -m | grep "Mem" | tr -s ' ' | cut -d ' ' -f4)" 

echo "CPU Load Average:$LOAD      Free RAM: $FREE MB" 
echo $'\n'
echo "NETWORK CONNECTIONS -----------------------------------"
echo $'\n'
echo "ACCOUNT INFORMATION -----------------------------------"

TOTAL_USERS="$(cat /etc/passwd | wc -l)"
ACTIVE_USERS="$( uptime | tr -d " " | cut -d ',' -f2 | head -c1)"
CURRENT_USER="$(who | cut -d " " -f1)"
SHELL="$(cat /etc/passwd | grep $CURRENT_USER | rev | cut -d ":" -f1 | rev)" 

echo "Total Users:    $TOTAL_USERS   Number Active: $ACTIVE_USERS"
echo "Most Frequently Used Shell: $SHELL"
