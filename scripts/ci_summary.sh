#!/bin/bash

DISK_STATUS=0
LOG_STATUS=0

echo "=========================================="
echo " CI PRE-CHECK SUMMARY "
echo "=========================================="

# Run Disk Check
./scripts/check_disk.sh
DISK_STATUS=$?

# Run Log Check
./scripts/check_logs.sh
LOG_STATUS=$?

echo "-----------------------------------"

if [ "$DISK_STATUS" -eq 0 ]; then
    echo " DISK CHECK : PASS"
else
    echo " DISK CHECK : FAIL"
fi

if [ "$LOG_STATUS" -eq 0 ]; then
    echo " LOG CHECK : PASS"
else
    echo " LOG CHECK : FAIL"
fi

echo "-----------------------------------"

#Decision logic

if [ "$DISK_STATUS" -ne 0 ]; then
    echo " CI RESULT : BLOCKED(DISK CRITERIA)"
    exit 1
elif [ "$LOG_STATUS" -ne 0 ]; then
    echo " CI RESULT : BLOCKED(LOG ERRORS)"
    exit 1
else
    echo " CI RESULT: PASSED "
    exit 0
fi