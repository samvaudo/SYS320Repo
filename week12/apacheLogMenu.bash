suspiciousVisitors#! /bin/bash

logFile="/var/log/apache2/access.log.1"

iocFile="ioc.txt"

function displayAllLogs(){
	cat "$logFile"
}

function displayOnlyIPs(){
        cat "$logFile" | cut -d ' ' -f 1 | sort -n | uniq -c
}

function displayOnlyPages(){
	cat "$logFile" | cut -d ' ' -f 7 | sort -n | uniq -c
}
function histogram(){

	local visitsPerDay=$(cat "$logFile" | cut -d " " -f 4,1 | tr -d '['  | sort \
                              | uniq)
	# This is for debugging, print here to see what it does to continue:
	echo "$visitsPerDay"

        :> newtemp.txt  # what :> does is in slides
	echo "$visitsPerDay" | while read -r line;
	do
		local withoutHours=$(echo "$line" | cut -d " " -f 2 \
                                     | cut -d ":" -f 1)
		local IP=$(echo "$line" | cut -d  " " -f 1)
		local newLine="$IP $withoutHours"
		echo "$IP $withoutHours" >> newtemp.txt
	done
	cat "newtemp.txt" | sort -n | uniq -c
}

function frequentVisitors(){
	#used histogram func but added an awk argument for if the number of visits is greater than or equal to 10
	local visitsPerDay=$(cat "$logFile" | cut -d " " -f 4,1 | tr -d '['  | sort \
                              | uniq)
        :> newtemp.txt  # what :> does is in slides
        echo "$visitsPerDay" | while read -r line;
        do
                local withoutHours=$(echo "$line" | cut -d " " -f 2 \
                                     | cut -d ":" -f 1)
                local IP=$(echo "$line" | cut -d  " " -f 1)
                local newLine="$IP $withoutHours"
                echo "$IP $withoutHours" >> newtemp.txt
        done
        cat "newtemp.txt" | sort -n | uniq -c | awk '{ if ($1 > 9) print $1 " " $2 " " $3 }'
} 

# function: suspiciousVisitors

function suspiciousVisitors(){
	local visitsWithIndicators=$(cat "$logFile" | cut -d " " -f 4,7 | tr -d '['  | sort \
                              | uniq)
	echo "$visitsWithIndicators" | awk '{ if (grep -q $2 $iocFile ) print $1 " " $2 }'
}
# Manually make a list of indicators of attack (ioc.txt)
# filter the records with this indicators of attack
# only display the unique count of IP addresses.  
# Hint: there are examples in slides

# Keep in mind that I have selected long way of doing things to 
# demonstrate loops, functions, etc. If you can do things simpler,
# it is welcomed.

while :
do
	echo "PLease select an option:"
	echo "[1] Display all Logs"
	echo "[2] Display only IPS"
	echo "[3] Display only Pages"
	echo "[4] Histogram"
	echo "[5] Display frequent visitors"
	echo "[6] Display suspicous visitors"
	echo "[7] Quit"

	read userInput
	echo ""

	if [[ "$userInput" == "7" ]]; then
		echo "Goodbye"
		break

	elif [[ "$userInput" == "1" ]]; then
		echo "Displaying all logs:"
		displayAllLogs

	elif [[ "$userInput" == "2" ]]; then
		echo "Displaying only IPS:"
		displayOnlyIPs

	elif [[ "$userInput" == "3" ]]; then
		echo "Displaying only Pages"
		displayOnlyPages

	elif [[ "$userInput" == "4" ]]; then
		echo "Histogram:"
		histogram

	elif [[ "$userInput" == "5" ]]; then
                echo "Displaying frequent Visitors"
               frequentVisitors


	elif [[ "$userInput" == "6" ]]; then
                echo "Displaying Suspicious Visitors"
                suspiciousVisitors
	fi
done
