df -hT / | tail -1 | tr -s   | cut -d   -f6 | sed s/%//
