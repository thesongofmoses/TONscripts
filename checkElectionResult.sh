#!/bin/bash

#VARIABLES
HOSTNAME=$(cat /etc/hostname)

#1 - get pububkey (adnl)
HALF_PUBKEY=$(cat ~/ton-keys/elections/$HOSTNAME-request-dump2 | grep 'public key' | awk '{print $11}' | tr '[:upper:]' '[:lower:]')
FULL_PUBKEY=$(printf "0x%s" "$HALF_PUBKEY")

#2 - check if pubkey is participating in current election and the staked amount
CHECK_PARTICIPATION=$(cd ~/net.ton.dev/tonos-cli/target/release && ./tonos-cli runget -1:3333333333333333333333333333333333333333333333333333333333333333 participates_in $FULL_PUBKEY | grep Result | awk '{print $2}' | tr -d '[' | tr -d '"' | tr -d ']')

#3 - get active-election-id of new election
CYCLE_DURATION=$(cd ~/net.ton.dev/ton/build/lite-client && ./lite-client -p ~/ton-keys/liteserver.pub -a 127.0.0.1:3031 -rc 'getconfig 15' -rc 'quit' 2>/dev/null | awk 'FNR == 4 {print $4}' | tr -d 'validators_elected_for:')
PREVIOUS_ELECTION_ID=$(cd ~/net.ton.dev/ton/build/lite-client && ./lite-client -p ~/ton-keys/liteserver.pub -a 127.0.0.1:3031 -rc 'getconfig 34' -rc 'quit' 2>/dev/null | grep utime | awk '{print $2}' | tr -d 'utime_since:')
CURRENT_ELECTION_ID=$(expr $PREVIOUS_ELECTION_ID + $CYCLE_DURATION)

#4 - convert the participating stake amount to regular unit
UNCONVERTED_TOKENS=$(printf "%d\n" "$CHECK_PARTICIPATION")
CONVERTED_TOKENS=$(expr "$UNCONVERTED_TOKENS" / 1000000000)

#5 - check if Elector confirms participation in current election and the amount
if [ "$CONVERTED_TOKENS" != "0" ]; then
        echo "-----------CONFIRMED-----------"
        printf "Current Election ID: "
        echo "$CURRENT_ELECTION_ID"
        printf "Staked Tokens: "
        echo "$CONVERTED_TOKENS"
        echo "-----------CONFIRMED-----------"
#6 - if amount equals zero, print warning msg
elif [ "$unconvertedTokens" == "0" ]; then
        echo "WARNING: Election failed"
        echo ""
        printf "Current Election ID: "
        echo "$CURRENT_ELECTION_ID"
        printf "Staked Tokens: "
        echo "$CONVERTED_TOKENS"

#7 - else, print unknown error msg
else
        echo "WARNING: Unknown Error"
fi
