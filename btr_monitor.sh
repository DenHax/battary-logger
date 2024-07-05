#!/bin/bash

scr_dir=$(dirname "$(realpath "$0")")

LOG_FILE="$scr_dir/battery_log.txt"
DATA_FILE="$scr_dir/battery_data.txt"

if [ ! -f "$LOG_FILE" ]; then
  touch "$LOG_FILE"
fi

if [ ! -f "$DATA_FILE" ]; then
  touch "$DATA_FILE"
fi

CURRENT_DATE=$(date +"%Y-%m-%d %H:%M:%S")
BATTERY_PERCENTS=$(acpi | awk '{print $4}' | tr -d ',')

echo "$CURRENT_DATE Percents: $BATTERY_PERCENTS" >>"$LOG_FILE"
echo "$(date +"%y-%m-%d %H:%M") $BATTERY_PERCENTS" >>"$DATA_FILE"

echo "Monitoring completed."
