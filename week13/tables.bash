#!/bin/bash

link="10.0.17.30/Assignment.html"

page=$(curl -sL "$link")

first_table=$(echo "$page" | \
xmlstarlet format --html --recover -n 2>/dev/null | \
xmlstarlet sel -t -m "//html//body//table[1]//tr" -v "td[1]" -o " " -v "td[2]" -n)

# Extract the second table (only the first column)
second_table=$(echo "$page" | \
xmlstarlet format --html --recover -n 2>/dev/null | \
xmlstarlet sel -t -m "//html//body//table[2]//tr" -v "td[1]" -n)

# Output the results
combined_output=$(paste <(echo "$second_table") <(echo "$first_table" | cut -d' ' -f1) <(echo "$first_table" | cut -d' ' -f2))

# Output the combined result
echo "$combined_output"
