#!/bin/bash

# Check if input is correct
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <log_file> <ioc_file>"
  exit 1
fi

LOG_FILE="$1"
IOC_FILE="$2"


# Check if valid locations
if [ ! -f "$LOG_FILE" ] || [ ! -f "$IOC_FILE" ]; then
  echo "Error: One or both files do not exist."
  exit 1
fi


OUTPUT_FILE="filtered_logs.txt"


# Takes required log variables given it matches the IOC
grep -f "$IOC_FILE" "$LOG_FILE" | \
awk '{print $1, $4, $5, $7}' | \
sed 's/\[//g' > "$OUTPUT_FILE"

# User confirm
echo "Filtered logs with IOCs have been saved to $OUTPUT_FILE."
