#!/bin/bash

#VARIABLES
HOSTNAME=$(cat /etc/hostname)
RED='\e[31m'
GREEN='\e[32m'
NO_COLOR='\e[0m'

#1 - get relevant keys: pubkey, election-adnl-key
HALF_PUBKEY=$(cat ~/ton-keys/elections/$HOSTNAME-request-dump2 | grep 'public key' | awk '{print $11}' | tr '[:upper:]' '[:lower:]')
FULL_PUBKEY=$(printf "0x%s" "$HALF_PUBKEY")
DIR_CURRENT_ELECTION_ADNL_KEY=$(cat ~/ton-keys/elections/$HOSTNAME-election-adnl-key | grep  "created new key" | awk '{print $4}')

#2 - check if pubkey is participating in current election and get the staked amount
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
STAKED_TOKENS=$CHECK_PARTICIPATION
UNCONVERTED_TOKENS=$(printf "%d\n" "$STAKED_TOKENS")
CONVERTED_TOKENS=$(echo "$UNCONVERTED_TOKENS"/1000000000 | bc -l)
ROUNDED_TOKENS=$(printf "%.9f" $CONVERTED_TOKENS)

#7 - get active-election-id of upcoming election from getconfig34
UPCOMING_ACTIVE_ELECTION_ID=$UNTIL_TIMESTAMP

#8 - calculate next cycle begin human time
NEXT_CYCLE_BEGIN_HUMANTIME=$(date -d @"$UNTIL_TIMESTAMP")

#9 - getconfig 36
        #9A - confirm election by getting my current-election-adnl-key in elections dir from getconfig 36
        GETCONFIG_CURRENT_ELECTION_ADNL_KEY=$(cd ~/net.ton.dev/ton/build/lite-client && ./lite-client -p ~/ton-keys/liteserver.pub -a 127.0.0.1:3031 -rc 'getconfig 36' -rc 'quit' 2>/dev/null | grep $DIR_CURRENT_ELECTION_ADNL_KEY | awk '{print $4}' | tr -d ')' | tr -d 'adnl_addr:x')

        #9B - calculate expected profit percentage
                #9BA - get my weight
                MY_WEIGHT=$(cd ~/net.ton.dev/ton/build/lite-client && ./lite-client -p ~/ton-keys/liteserver.pub -a 127.0.0.1:3031 -rc 'getconfig 36' -rc 'quit' 2>/dev/null | grep $DIR_CURRENT_ELECTION_ADNL_KEY | awk '{print $3}' | tr -d 'weight:')

                #9BB - get network total weight
                TOTAL_WEIGHT=$(cd ~/net.ton.dev/ton/build/lite-client && ./lite-client -p ~/ton-keys/liteserver.pub -a 127.0.0.1:3031 -rc 'getconfig 36' -rc 'quit' 2>/dev/null | grep 'total_weight' | awk '{print $6}' | tr -d 'total_weight:')

                #9BC - calculate my profit percentage
                MY_WEIGHT_PERCENTAGE=$(echo $MY_WEIGHT/$TOTAL_WEIGHT | bc -l)


#10 - check if Elector confirms participation in current election and the amount
if [ "$ROUNDED_TOKENS" != "0.000000000" ]; then
    printf "${GREEN}---------CURRENT ELECTION---------\n"
        printf "Election ID: "
        printf "$UPCOMING_ACTIVE_ELECTION_ID\n"
        printf "Staked Tokens: "
        printf "$ROUNDED_TOKENS\n"
        echo "----------ELECTION UNTIL----------"
        echo "---$UPCOMING_ELECTION_END_HUMANTIME---"
        echo "-------SUBMISSION CONFIRMED-------"
        printf "${NO_COLOR}"

#11 - otherwise, check getconfig 36 to see if elected as next set of validators
elif [ "$GETCONFIG_CURRENT_ELECTION_ADNL_KEY" == "$DIR_CURRENT_ELECTION_ADNL_KEY" ]; then
  printf "${GREEN}----------UPCOMING CYCLE----------\n"
        printf "Election ID: "
        printf "$UPCOMING_ACTIVE_ELECTION_ID\n"
        printf "Expected Rewards: "
        printf "<ADD AMOUNT>\n" ## calculate expected fees based on data from previous elections
        printf "Expected Interest: "
        printf "%.9f" $MY_WEIGHT_PERCENTAGE ## calculate expected interest rate relative to $staked amount
        echo '%'
        echo "----VALIDATION ELECTION BEGINS----"
        echo "---$NEXT_CYCLE_BEGIN_HUMANTIME---"
        echo "---------ELECTED VALIDATOR--------"
        printf "${NO_COLOR}"

#12 - if amount equals zero, print warning msg
elif [ "$ROUNDED_TOKENS" == "0.000000000" ]; then
        printf "${RED}WARNING: NO STAKES FOUND"
        printf "Election ID: "
        echo "$UPCOMING_ACTIVE_ELECTION_ID"
        printf "Staked Tokens: "
        echo "$ROUNDED_TOKENS"
        printf 'ELECTION UNTIL: '
        printf "$UPCOMING_ELECTION_END_HUMANTIME${NO_COLOR}"

#13 - else, print unknown error msg
else
        echo "WARNING: Unknown Error"
fi
