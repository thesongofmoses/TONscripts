#!/bin/bash

. ~/node.operator/configs/master.config

# print calendar
echo '--------------ELECTIONS-------------'     
echo 'Previous Election'
printf 'Active Election ID: '
echo "$PREVIOUS_ACTIVE_ELECTION_ID"
printf "Since:  "
echo "$PREVIOUS_ELECTION_SINCE_HUMANTIME"
printf "Until:  "
echo "$PREVIOUS_ELECTION_UNTIL_HUMANTIME"
echo ""

echo 'Upcoming Election'
printf 'Active Election ID: '
echo "$UPCOMING_ACTIVE_ELECTION_ID"
printf "Since:  "
echo "$UPCOMING_ELECTION_SINCE_HUMANTIME"
printf "Until:  "
echo "$UPCOMING_ELECTION_UNTIL_HUMANTIME"
echo ""

echo 'Next Election'
printf 'Active Election ID: '
echo "$NEXT_ACTIVE_ELECTION_ID"
printf "Since:  "
echo "$NEXT_ELECTION_SINCE_HUMANTIME"
printf "Until:  "
echo "$NEXT_ELECTION_UNTIL_HUMANTIME"
echo ""

echo '--------------VALIDATION------------'
echo 'Previous Cycle'
printf "Since:  "
echo "$PREVIOUS_VALIDATION_SINCE_HUMANTIME" 
printf "Until:  "
echo "$PREVIOUS_VALIDATION_UNTIL_HUMANTIME"
echo ""

echo 'Current Cycle'
printf "Since:  "
echo "$CURRENT_VALIDATION_SINCE_HUMANTIME"
printf "Until:  "
echo "$CURRENT_VALIDATION_UNTIL_HUMANTIME"
echo ""

echo 'Next Cycle'
printf "Since:  "  
echo "$NEXT_VALIDATION_SINCE_HUMANTIME"
printf "Until:  "
echo "$NEXT_VALIDATION_UNTIL_HUMANTIME"
