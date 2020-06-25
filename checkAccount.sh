#!/bin/bash

#VARIABLES
HOSTNAME=$(cat /etc/hostname)

#1 - get my raw address
MY_RAW_ADDRESS=$(cat ~/ton-keys/$HOSTNAME.addr)

#2 - get my account info
MY_ACCOUNT=$(cd ~/net.ton.dev/ton/build/lite-client && ./lite-client -p ~/ton-keys/liteserver.pub -a 127.0.0.1:3031 -rc "getaccount ${MY_RAW_ADDRESS}" -rc 'quit' 2>/dev/null)

#3 - parse account status
ACCOUNT_STATUS=$(echo "$MY_ACCOUNT" | grep account | awk 'FNR == 3 {print $1}' | perl -ne '/state:\(account_(\S+)/ && print $1')

#4 - parse last transaction time
LAST_TRANS_LT=$(echo "$MY_ACCOUNT" | grep account | awk 'FNR == 2 {print $2}' | tr -d 'last_trans_lt:')

#5 parse last transaction
LAST_TIME=$(echo "$MY_ACCOUNT" | grep last_paid | awk '{print $4}' | tr -d 'last_paid:')
CONVERTED_LAST_TIME=$(date -d @"$LAST_TIME")

#6 - print account info
printf "Address: "
echo $MY_RAW_ADDRESS
printf "Status: "
echo $ACCOUNT_STATUS
printf "Last Transaction Logical Time: "
echo $LAST_TRANS_LT
printf "Last Transaction Time: "
echo $CONVERTED_LAST_TIME
