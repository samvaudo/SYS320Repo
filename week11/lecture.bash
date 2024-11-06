#!bin/bash

file="/var/log/apache2/access.log"

grep "page2.html" $file | awk '{print $1 $7}' | grep "page2.html"

