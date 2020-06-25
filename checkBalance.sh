#!/bin/bash

#VARIABLES
HOSTNAME=$(cat /etc/hostname)

#1 - get my raw address
MY_RAW_ADDRESS=$(cat ~/ton-keys/$HOSTNAME.addr)

#2 - get my account info
MY_ACCOUNT=$(cd ~/net.ton.dev/ton/build/lite-client && ./lite-client -p ~/ton-keys/liteserver.pub -a 127.0.0.1:3031 -rc "getaccount ${MY_RAW_ADDRESS}" -rc 'quit' 2>/dev/null)

#3 - grep balance
MY_BALANCE=$(echo "$MY_ACCOUNT" | tail -n 1 | tr -d '=''ng' | awk '{print $4}')

#4 - convert tokens to regular unit
CONVERTED_TOKENS=$(echo "$MY_BALANCE"/1000000000 | bc -l)

#5 display balance up to 9 decimals
function balance () {
        printf "Wallet Balance: "
        echo ""
        printf "%.9f" $CONVERTED_TOKENS
}

balance
