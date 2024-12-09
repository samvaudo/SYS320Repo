#!/bin/bash

# URL specified
URL="http://10.0.17.15/IOC.html"

OUTPUT_FILE="IOC.txt"

# Takes the table of the URL and gets only the first row
curl -s "$URL" | \
grep -oP '(?<=<td>)[^<]+(?=</td>)' | \
awk 'NR % 2 == 1' > "$OUTPUT_FILE"

# User confirm
echo "Indicators of Compromise have been saved to $OUTPUT_FILE."
