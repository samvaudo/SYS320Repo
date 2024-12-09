#!/bin/bash
URL="http://10.0.17.15/IOC.html"

OUTPUT_FILE="IOC.txt"


curl -s "$URL" | \
grep -oP '(?<=<td>)[^<]+(?=</td>)' | \
awk 'NR % 2 == 1' > "$OUTPUT_FILE"

echo "Indicators of Compromise have been saved to $OUTPUT_FILE."
