#!/bin/bash

THRESHOLD=80
alert=0

echo " Checking Disk Usage.... "

while read -r fs size used avail use mount; do
    usage=${use%\%}

    if [[ "$usage" =~ ^[0-9]+$ ]] && [ "$usage" -ge "$THRESHOLD" ]; then
        echo "High Disk Usage on $mount ($usage%)"
        alert=1
    fi

done < <(df -h | tail -n +2)

if [ "$alert" -eq 1 ]; then
    echo "Disk check failed"
    exit 1
else
    echo "Disk check passed"
    exit 0
fi