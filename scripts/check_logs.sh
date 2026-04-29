#!/bin/bash

LOG_FILE="logs/app.log"
ERROR_LIMIT=2

echo " Checking application logs..... "

if [ ! -f "$LOG_FILE" ]; then
    echo "Log file not found $LOGFILE"
    exit 1
fi

ERROR_COUNT=$(grep -c "ERROR" "$LOG_FILE")

echo " Error count: $ERROR_COUNT"

if [ "$ERROR_COUNT" -gt "$ERROR_LIMIT" ]; then
    echo " Error count exceeded limit ($ERROR_LIMIT)"
    exit 1
else
    echo "Log check passed"
    exit 0
fi
