#!/bin/bash

# Check for input
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <filtered_logs_file>"
  exit 1
fi

FILTERED_LOGS="$1"

# Check if valid
if [ ! -f "$FILTERED_LOGS" ]; then
  echo "Error: File '$FILTERED_LOGS' does not exist."
  exit 1
fi

# HTML output
OUTPUT_HTML="/var/www/html/report.html"

# Begin HTML 
cat <<EOT > "$OUTPUT_HTML"
<!DOCTYPE html>
<html>
<head>
    <title>Access Logs with IOC Indicators</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h1>Access Logs with IOC Indicators</h1>
    <table>
        <tr>
            <th>IP Address</th>
            <th>Date/Time</th>
            <th>Page Accessed</th>
        </tr>
EOT

# Add table rows from the logs
while read -r line; do
    IP=$(echo "$line" | awk '{print $1}')
    DATE=$(echo "$line" | awk '{print $2, $3}')
    PAGE=$(echo "$line" | awk '{print $4}')
    echo "        <tr><td>$IP</td><td>$DATE</td><td>$PAGE</td></tr>" >> "$OUTPUT_HTML"
done < "$FILTERED_LOGS"

# End HTML
cat <<EOT >> "$OUTPUT_HTML"
    </table>
</body>
</html>
EOT

# User confirm
echo "HTML file created: $OUTPUT_HTML"
