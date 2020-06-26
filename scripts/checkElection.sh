#!/bin/bash

#VARIABLES
HOSTNAME=$(cat /etc/hostname)

#1 - get pububkey (adnl)
HALF_PUBKEY=$(cat ~/ton-keys/elections/$HOSTNAME-request-dump2 | grep 'public key' | awk '{print $11}' | tr '[:upper:]' '[:lower:]')
FULL_PUBKEY=$(printf "0x%s" "$HALF_PUBKEY")

#2 - check if pubkey is participating in current election and the staked amount
CHECK_PARTICIPATION=$(cd ~/net.ton.dev/ton/build/lite-client && ./lite-client -p ~/ton-keys/liteserver.pub -a 127.0.0.1:3031 -rc "runmethodfull -1:33333333333333333333333333333333333333333333333$

#3 - get active-election-id of new election
CYCLE_DURATION=$(cd ~/net.ton.dev/ton/build/lite-client && ./lite-client -p ~/ton-keys/liteserver.pub -a 127.0.0.1:3031 -rc 'getconfig 15' -rc 'quit' 2>/dev/null | awk 'FNR == 4 {print $4}' | tr$
PREVIOUS_ELECTION_ID=$(cd ~/net.ton.dev/ton/build/lite-client && ./lite-client -p ~/ton-keys/liteserver.pub -a 127.0.0.1:3031 -rc 'getconfig 34' -rc 'quit' 2>/dev/null | grep utime | awk '{print$

#4 = get the current election human time
CURRENT_ELECTION_TIME=$(date -d @$PREVIOUS_ELECTION_ID)

#5 - convert the participating stake amount to regular unit
UNCONVERTED_TOKENS=$(printf "%d\n" "$CHECK_PARTICIPATION")
CONVERTED_TOKENS=$(echo "$UNCONVERTED_TOKENS"/1000000000 | bc -l)
ROUNDED_TOKENS=$(printf "%.9f" $CONVERTED_TOKENS)

#6 - check if Elector confirms participation in current election and the amount
if [ "$ROUNDED_TOKENS" != "0.000000000" ]; then
        echo "---------CURRENT ELECTION---------"
        printf "ID: "
        echo "$PREVIOUS_ELECTION_ID"
        printf "Staked Tokens: "
        echo "$ROUNDED_TOKENS"
        echo "---$CURRENT_ELECTION_TIME---"
        echo "-------------CONFIRMED------------"

#7 - if amount equals zero, print warning msg
elif [ "$ROUNDED_TOKENS" == "0.000000000" ]; then
        echo "WARNING: Election submission failed"
        printf "Current Election ID: "
        echo "$PREVIOUS_ELECTION_ID"
        printf "Staked Tokens: "
        echo "$ROUNDED_TOKENS"
        echo "$CURRENT_ELECTION_TIME"

#8 - else, print unknown error msg
else
        echo "WARNING: Unknown Error"
fi
