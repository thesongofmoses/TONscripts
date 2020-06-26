#!/bin/bash

#1 - get timestamps from getconfig 34
SINCE_TIMESTAMP=$(cd ~/net.ton.dev/ton/build/lite-client && ./lite-client -p ~/ton-keys/liteserver.pub -a 127.0.0.1:3031 -rc 'getconfig 34' -rc 'quit' 2>/dev/null | grep time | awk '{print $2}' | tr -d 'utime_since:')
UNTIL_TIMESTAMP=$(cd ~/net.ton.dev/ton/build/lite-client && ./lite-client -p ~/ton-keys/liteserver.pub -a 127.0.0.1:3031 -rc 'getconfig 34' -rc 'quit' 2>/dev/null | grep time | awk '{print $3}' | tr -d 'utime_until:')


#2 - get relative election start/end in unixtime from getconfig 15
ELECTION_START_BEFORE=$(cd ~/net.ton.dev/ton/build/lite-client && ./lite-client -p ~/ton-keys/liteserver.pub -a 127.0.0.1:3031 -rc 'getconfig 15' -rc 'quit' 2>/dev/null | awk 'FNR == 4 {print $5}' | tr -d 'elections_start_before:')
ELECTION_END_BEFORE=$(cd ~/net.ton.dev/ton/build/lite-client && ./lite-client -p ~/ton-keys/liteserver.pub -a 127.0.0.1:3031 -rc 'getconfig 15' -rc 'quit' 2>/dev/null | awk 'FNR == 4 {print $6}' | tr -d 'elections_end_before:')


#3 - get the duration of cycle parameter in unixtime from getconfig 15
CYCLE_DURATION=$(cd ~/net.ton.dev/ton/build/lite-client && ./lite-client -p ~/ton-keys/liteserver.pub -a 127.0.0.1:3031 -rc 'getconfig 15' -rc 'quit' 2>/dev/null | awk 'FNR == 4 {print $4}' | tr -d 'validators_elected_for:')


#4 - calculate election cycles
#4A - calculate previous election start/end in unixtime and active-election-id
PREVIOUS_ACTIVE_ELECTION_ID=$(expr $SINCE_TIMESTAMP - $CYCLE_DURATION)
PREVIOUS_ELECTION_START_UNIXTIME=$(expr $UNTIL_TIMESTAMP - $ELECTION_START_BEFORE - $CYCLE_DURATION)
PREVIOUS_ELECTION_END_UNIXTIME=$(expr $UNTIL_TIMESTAMP - $ELECTION_END_BEFORE - $CYCLE_DURATION)

#4B - calculate upcoming election start/end in unixtime and active-election-id
UPCOMING_ACTIVE_ELECTION_ID=$UNTIL_TIMESTAMP
UPCOMING_ELECTION_START_UNIXTIME=$(expr $UNTIL_TIMESTAMP - $ELECTION_START_BEFORE)
UPCOMING_ELECTION_END_UNIXTIME=$(expr $UNTIL_TIMESTAMP - $ELECTION_END_BEFORE)

#4C - calculate next election start/end in unixtime and active-election-id
NEXT_ACTIVE_ELECTION_ID=$(expr $UNTIL_TIMESTAMP + $CYCLE_DURATION)
NEXT_ELECTION_START_UNIXTIME=$(expr $UNTIL_TIMESTAMP - $ELECTION_START_BEFORE + $CYCLE_DURATION)
NEXT_ELECTION_END_UNIXTIME=$(expr $UNTIL_TIMESTAMP - $ELECTION_END_BEFORE + $CYCLE_DURATION)


#5 - calculate validation cycles
#5A - calculate previous validation cycle in unixtime
PREVIOUS_VALIDATION_START_UNIXTIME=$(expr $SINCE_TIMESTAMP - $CYCLE_DURATION)
PREVIOUS_VALIDATION_END_UNIXTIME=$(expr $UNTIL_TIMESTAMP - $CYCLE_DURATION)

#5B - calculate current validation cycle in unixtime
CURRENT_VALIDATION_START_UNIXTIME=$SINCE_TIMESTAMP
CURRENT_VALIDATION_END_UNIXTIME=$UNTIL_TIMESTAMP

#5C - calculate next validation cycle in unixtime
NEXT_VALIDATION_START_UNIXTIME=$(expr $SINCE_TIMESTAMP + $CYCLE_DURATION)
NEXT_VALIDATION_END_UNIXTIME=$(expr $UNTIL_TIMESTAMP + $CYCLE_DURATION)


#6 - convert all unixtime to human time
#6A - previous election cycle to humantime
PREVIOUS_ELECTION_START_HUMANTIME=$(date -d @"$PREVIOUS_ELECTION_START_UNIXTIME")
PREVIOUS_ELECTION_END_HUMANTIME=$(date -d @"$PREVIOUS_ELECTION_END_UNIXTIME")

#6B - upcoming election cycle to humantime
UPCOMING_ELECTION_START_HUMANTIME=$(date -d @"$UPCOMING_ELECTION_START_UNIXTIME")
UPCOMING_ELECTION_END_HUMANTIME=$(date -d @"$UPCOMING_ELECTION_END_UNIXTIME")

#6C - next election cycle to humantime
NEXT_ELECTION_START_HUMANTIME=$(date -d @"$NEXT_ELECTION_START_UNIXTIME")
NEXT_ELECTION_END_HUMANTIME=$(date -d @"$NEXT_ELECTION_END_UNIXTIME")

#6D - previous validation cycle to humantime
PREVIOUS_VALIDATION_START_HUMANTIME=$(date -d @"$PREVIOUS_VALIDATION_START_UNIXTIME")
PREVIOUS_VALIDATION_END_HUMANTIME=$(date -d @"$PREVIOUS_VALIDATION_END_UNIXTIME")

#6E - current validation cycle to humantime
CURRENT_VALIDATION_START_HUMANTIME=$(date -d @"$CURRENT_VALIDATION_START_UNIXTIME")
CURRENT_VALIDATION_END_HUMANTIME=$(date -d @"$CURRENT_VALIDATION_END_UNIXTIME")

#6F - next validation cycle to humantime
NEXT_VALIDATION_START_HUMANTIME=$(date -d @"$NEXT_VALIDATION_START_UNIXTIME")
NEXT_VALIDATION_END_HUMANTIME=$(date -d @"$NEXT_VALIDATION_END_UNIXTIME")


#7 - print calendar
echo '--------------ELECTIONS-------------'
echo 'Previous Election'
printf 'Active Election ID: '
echo "$PREVIOUS_ACTIVE_ELECTION_ID"
printf "Since:  "
echo "$PREVIOUS_ELECTION_START_HUMANTIME"
printf "Until:  "
echo "$PREVIOUS_ELECTION_END_HUMANTIME"
echo ""

echo 'Upcoming Election'
printf 'Active Election ID: '
echo "$UPCOMING_ACTIVE_ELECTION_ID"
printf "Since:  "
echo "$UPCOMING_ELECTION_START_HUMANTIME"
echo "$UPCOMING_ELECTION_END_HUMANTIME"
echo ""

echo 'Next Election'
printf 'Active Election ID: '
echo "$NEXT_ACTIVE_ELECTION_ID"
printf "Since:  "
echo "$NEXT_ELECTION_START_HUMANTIME"
printf "Until:  "
echo "$NEXT_ELECTION_END_HUMANTIME"
echo ""

echo '--------------VALIDATION------------'
echo 'Previous Cycle'
printf "Since:  "
echo "$PREVIOUS_VALIDATION_START_HUMANTIME"
printf "Until:  "
echo "$PREVIOUS_VALIDATION_END_HUMANTIME"
echo ""

echo 'Current Cycle'
printf "Since:  "
echo "$CURRENT_VALIDATION_START_HUMANTIME"
printf "Until:  "
echo "$CURRENT_VALIDATION_END_HUMANTIME"
echo ""

echo 'Next Cycle'
printf "Since:  "
echo "$NEXT_VALIDATION_START_HUMANTIME"
printf "Until:  "
echo "$NEXT_VALIDATION_END_HUMANTIME"
