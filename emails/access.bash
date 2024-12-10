#!/bin/bash



date +"%a %b %H-%M-%S %Z %Y" >> fileaccesslog.txt


echo "To: samuel.vaudo@mymail.champlain.edu" > logform.txt
echo "Subject: Access" >> logform.txt
echo "$(cat fileaccesslog.txt)" >> logform.txt
cat logform.txt | ssmtp samuel.vaudo@mymail.champlain.edu
