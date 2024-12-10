#!/bin/bash

authfile="/var/log/auth.log"

function getLogins(){
 logline=$(cat "$authfile" | grep "systemd-logind" | grep "New session")
 dateAndUser=$(echo "$logline" | cut -d' ' -f1,2,11 | tr -d '\.')
 echo "$dateAndUser" 
}
#TODO-1
function getFailedLogins(){
	failedLogins=$(cat "$authfile" | grep "Failed password")
	dateAndUser=$(echo "$failedLogins" | awk '{print $1, $2, $3, $11, $13}')
	echo "$dateAndUser"
}

# Sending logins as email - Do not forget to change email address
# to your own email address
echo "To: samuel.vaudo@mymail.champlain.edu" > emailform.txt
echo "Subject: Logins" >> emailform.txt
getLogins >> emailform.txt
cat emailform.txt | ssmtp samuel.vaudo@mymail.champlain.edu

#TODO-2
#Send failed logins as email to yourself.
echo "To: samuel.vaudo@mymail.champlain.edu" > failedemailform.txt
echo "Subject: Failed Logins" >> failedemailform.txt
getFailedLogins >> emailform.txt
cat failedemailform.txt | ssmtp samuel.vaudo@mymail.champlain.edu
