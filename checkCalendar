#!/bin/bash

#1 - get timestamps from getconfig 34
SINCE_TIMESTAMP=$(cd ~/net.ton.dev/ton/build/lite-client && ./lite-client -p ~/ton-keys/liteserver.pub -a 127.0.0.1:3031 -rc 'getconfig 34' -rc 'quit' 2>/dev/null | grep time | awk '{print $2}' | tr -d 'utime_since:')
UNTIL_TIMESTAMP=$(cd ~/net.ton.dev/ton/build/lite-client && ./lite-client -p ~/ton-keys/liteserver.pub -a 127.0.0.1:3031 -rc 'getconfig 34' -rc 'quit' 2>/dev/null | grep time | awk '{print $3}' | tr -d 'utime_until:')

#2 - get relative election start and end time compared to getconfig 15
ELECTION_END_BEFORE=$(cd ~/net.ton.dev/ton/build/lite-client && ./lite-client -p ~/ton-keys/liteserver.pub -a 127.0.0.1:3031 -rc 'getconfig 15' -rc 'quit' 2>/dev/null | awk 'FNR == 4 {print $6}' | tr -d 'elections_end_before:')
ELECTION_START_BEFORE=$(cd ~/net.ton.dev/ton/build/lite-client && ./lite-client -p ~/ton-keys/liteserver.pub -a 127.0.0.1:3031 -rc 'getconfig 15' -rc 'quit' 2>/dev/null | awk 'FNR == 4 {print $5}' | tr -d 'elections_start_before:')

#3 - calculate next election start and end unix timestamp
UNIX_ELECTION_START_TIME=$(expr $UNTIL_TIMESTAMP - $ELECTION_START_BEFORE)
UNIX_ELECTION_END_TIME=$(expr $UNTIL_TIMESTAMP - $ELECTION_END_BEFORE)

#4 - convert it to human time
#FUNCTIONS
function SINCE_TIME () {
        printf "Election Starts:        "
        date -d @"$UNIX_ELECTION_START_TIME"
}

function UNTIL_TIME () {
        printf "Election Ends:          "
        date -d @"$UNIX_ELECTION_END_TIME"
}

#5 - ccalculate next election time
CYCLE_DURATION=$(cd ~/net.ton.dev/ton/build/lite-client && ./lite-client -p ~/ton-keys/liteserver.pub -a 127.0.0.1:3031 -rc 'getconfig 15' -rc 'quit' 2>/dev/null | awk 'FNR == 4 {print $4}' | tr -d 'validators_elected_for:')
UNIX_NEXT_ELECTION_START_TIME=$(expr $UNIX_ELECTION_START_TIME + $CYCLE_DURATION)
UNIX_NEXT_ELECTION_END_TIME=$(expr $UNIX_ELECTION_END_TIME + $CYCLE_DURATION)

function NEXT_SINCE_TIME () {
        printf "Election Starts:        "
        date -d @"$UNIX_NEXT_ELECTION_START_TIME"
}

function NEXT_UNTIL_TIME () {
        printf "Election Ends:          "
        date -d @"$UNIX_NEXT_ELECTION_END_TIME"
}

#6 - get current validator cycle duration
CURRENT_VALIDATION_START_TIME=$(cd ~/net.ton.dev/ton/build/lite-client && ./lite-client -p ~/ton-keys/liteserver.pub -a 127.0.0.1:3031 -rc 'getconfig 34' -rc 'quit' 2>/dev/null | grep time | awk '{print $2}' | tr -d 'utime_since:')
CURRENT_VALIDATION_END_TIME=$(cd ~/net.ton.dev/ton/build/lite-client && ./lite-client -p ~/ton-keys/liteserver.pub -a 127.0.0.1:3031 -rc 'getconfig 34' -rc 'quit' 2>/dev/null | grep time | awk '{print $3}' | tr -d 'utime_until:')

function CURRENT_CYCLE_START_TIME () {
        printf "Validation started:     "
        date -d @"$CURRENT_VALIDATION_START_TIME"
}

function CURRENT_CYCLE_END_TIME () {
        printf "Validation Ends:        "
        date -d @"$CURRENT_VALIDATION_END_TIME"
}

#7 - get next validator cycle duration
NEXT_VALIDATION_START_TIME=$(expr $CURRENT_VALIDATION_START_TIME + $CYCLE_DURATION)
NEXT_VALIDATION_END_TIME=$(expr $CURRENT_VALIDATION_END_TIME + $CYCLE_DURATION)

function NEXT_CYCLE_START_TIME () {
        printf "Validation will start:  "
        date -d @"$NEXT_VALIDATION_START_TIME"
}

function NEXT_CYCLE_END_TIME () {
        printf "Validation will end:    "
        date -d @"$NEXT_VALIDATION_END_TIME"
}

#8 - echo calendar

echo 'Upcoming Election'
SINCE_TIME
UNTIL_TIME
echo ""
echo 'Next Election'
NEXT_SINCE_TIME
NEXT_UNTIL_TIME
echo ""
echo 'Current Cycle'
CURRENT_CYCLE_START_TIME
CURRENT_CYCLE_END_TIME
echo ""
echo 'Next Cycle'
NEXT_CYCLE_START_TIME
NEXT_CYCLE_END_TIME
