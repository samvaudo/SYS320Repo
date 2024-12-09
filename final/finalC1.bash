#!/bin/bash

# URL of the hosted HTML file
URL="http://10.0.17.15/IOC.html"

# Output file
OUTPUT_FILE="IOC.txt"

# Fetch the HTML file and extract the IOCs
curl -s "$URL" | \
grep -oP '(?<=<td>)[^<]+(?=</td>)' | \
awk 'NR % 2 == 1' > "$OUTPUT_FILE"

# Inform the user
echo "Indicators of Compromise have been saved to $OUTPUT_FILE."
