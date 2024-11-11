#!bin/bash


file="/var/log/apache2/access.log"



function pageCount(){

	cut -d' ' -f7 "$file" | sort | uniq -c | sort -nr

}

#pageCount

function countingCurlAccess(){

	grep "curl" "$file" | awk '{print $1, $12}' | sort | uniq -c | sort -nr

}

countingCurlAccess


