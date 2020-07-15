#!/bin/bash

CHECK_ACCOUNT=$(cd ~/net.ton.dev/ton/build/lite-client && ./lite-client -p ~/ton-keys/liteserver.pub -a 127.0.0.1:3031 -rc "getaccount ${1}" -rc 'quit' 2>/dev/null)
CHECK_ACCOUNT_STATUS=$(echo "$CHECK_ACCOUNT" | grep account | awk 'FNR == 3 {print $1}' | perl -ne '/state:\(account_(\S+)/ && print $1')
LAST_TRANS_LT=$(echo "$CHECK_ACCOUNT" | grep account | awk 'FNR == 2 {print $2}' | tr -d 'last_trans_lt:')
LAST_TX_UNIXTIME=$(echo "$CHECK_ACCOUNT" | grep last_paid | awk '{print $4}' | tr -d 'last_paid:')
LAST_TX_HUMANTIME=$(date -d @"$LAST_TX_UNIXTIME")

CHECK_NANO_BALANCE=$(echo "$CHECK_ACCOUNT" | tail -n 1 | tr -d '=''ng' | awk '{print $4}')
CHECK_BALANCE=$(echo "scale=9; $CHECK_NANO_BALANCE"/1000000000 | bc -l)

printf "Address: "
echo $CHECK_RAW_ADDRESS
printf "Status: "
echo $CHECK_ACCOUNT_STATUS
printf "Balance: "
echo $CHECK_BALANCE
printf "Last Transaction Logical Time: "
echo $LAST_TRANS_LT
printf "Last Transaction Time: "
echo $LAST_TX_HUMANTIME
