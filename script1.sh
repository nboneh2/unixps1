#!/bin/bash

#Requesting just the / directory, taking tail 1 to get rid of header line 
#using trim to get rid of repeating spaces to make it suitable for cut
#cutting on spaces and choosing the 6 value which is the space used
#remove the % sign with nothing using sed, so we can use the value as an int

SPACEUSED="$(df -hT / | tail -1 | tr -s ' '  | cut -d ' ' -f6 | sed s/%//)"

while [ $SPACEUSED -lt 80 ]
do
echo "Current spaceused: $SPACEUSED% (not critical)"
sleep 1
done

#Sending mail to root
echo "Current spaceused: $SPACEUSED% (critical) sending mail to root account"

echo "Current space being used is $SPACEUSED%" | mail -s "Spaceused on system is critical" root 

