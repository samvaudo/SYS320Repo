#!bin/bash


file="/var/log/apache2/access.log"



function pageCount(){

	cut -d' ' -f7 "$file" | sort | uniq -c | sort -nr

}

pageCount
