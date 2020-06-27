#!/bin/bash

#VARIABLES
HOSTNAME=$(cat /etc/hostname)
RED='\e[31m'
GREEN='\e[32m'
NO_COLOR='\e[0m'

#1 - get pububkey (adnl)
HALF_PUBKEY=$(cat ~/ton-keys/elections/$HOSTNAME-request-dump2 | grep 'public key' | awk '{print $11}' | tr '[:upper:]' '[:lower:]')
FULL_PUBKEY=$(printf "0x%s" "$HALF_PUBKEY")

#2 - check if pubkey is participating in current election and the staked amount
CHECK_PARTICIPATION=$(cd ~/net.ton.dev/ton/build/lite-client && ./lite-client -p ~/ton-keys/liteserver.pub -a 127.0.0.1:3031 -rc "runmethodfull -1:3333333333333333333333333333333333333333333333333333333333333333 participates_in ${FULL_PUBKEY}" -rc 'quit' 2>/dev/null | awk 'FNR == 5 {print $3}')

#3 - get cycle duration from getconfig15
CYCLE_DURATION=$(cd ~/net.ton.dev/ton/build/lite-client && ./lite-client -p ~/ton-keys/liteserver.pub -a 127.0.0.1:3031 -rc 'getconfig 15' -rc 'quit' 2>/dev/null | awk 'FNR == 4 {print $4}' | tr -d 'validators_elected_for:')

#4 - get end time of upcoming election in unixtime
UNTIL_TIMESTAMP=$(cd ~/net.ton.dev/ton/build/lite-client && ./lite-client -p ~/ton-keys/liteserver.pub -a 127.0.0.1:3031 -rc 'getconfig 34' -rc 'quit' 2>/dev/null | grep time | awk '{print $3}' | tr -d 'utime_until:')
ELECTION_END_BEFORE=$(cd ~/net.ton.dev/ton/build/lite-client && ./lite-client -p ~/ton-keys/liteserver.pub -a 127.0.0.1:3031 -rc 'getconfig 15' -rc 'quit' 2>/dev/null | awk 'FNR == 4 {print $6}' | tr -d 'elections_end_before:')
UPCOMING_ELECTION_END_UNIXTIME=$(expr $UNTIL_TIMESTAMP - $ELECTION_END_BEFORE)

#5 = get the end time of upcoming election in human time
UPCOMING_ELECTION_END_HUMANTIME=$(date -d @"$UPCOMING_ELECTION_END_UNIXTIME")

#6 - convert the participating stake amount to regular unit
UNCONVERTED_TOKENS=$(printf "%d\n" "$CHECK_PARTICIPATION")
CONVERTED_TOKENS=$(echo "$UNCONVERTED_TOKENS"/1000000000 | bc -l)
ROUNDED_TOKENS=$(printf "%.9f" $CONVERTED_TOKENS)

#7 - get active-election-id of upcoming election from getconfig34
UPCOMING_ACTIVE_ELECTION_ID=$UNTIL_TIMESTAMP


#8 - check if Elector confirms participation in current election and the amount
if [ "$ROUNDED_TOKENS" != "0.000000000" ]; then
    printf "${GREEN}---------CURRENT ELECTION---------\n"
        printf "ID: "
        printf "$UPCOMING_ACTIVE_ELECTION_ID\n"
        printf "Staked Tokens: "
        printf "$ROUNDED_TOKENS\n"
        echo "----------ELECTION UNTIL----------"
        echo "---$UPCOMING_ELECTION_END_HUMANTIME---"
        echo "-------------CONFIRMED------------"
        printf "${NO_COLOR}"

#9 - if amount equals zero, print warning msg
elif [ "$ROUNDED_TOKENS" == "0.000000000" ]; then
        printf "${RED}WARNING: NO STAKES FOUND"
        printf "Current Election ID: "
        echo "$UPCOMING_ACTIVE_ELECTION_ID"
        printf "Staked Tokens: "
        echo "$ROUNDED_TOKENS"
        printf 'ELECTION UNTIL: '
        printf "$UPCOMING_ELECTION_END_HUMANTIME${NO_COLOR}"

#10 - else, print unknown error msg
else
        echo "WARNING: Unknown Error"
fi
