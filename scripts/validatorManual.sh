#!/bin/bash

HOSTNAME=$(cat /etc/hostname)

#variables
MY_RAW_ADDRESS=$(cat ~/ton-keys/$HOSTNAME.addr)
BOC=$(cd ~/ton-keys/elections && echo $(base64 --wrap=0 "validator-query.boc"))
MSIG_KEYS_JSON="~/ton-keys/msig.keys.json"
ABI_JSON="~/net.ton.dev/configs/SafeMultisigWallet.abi.json"
ECHO_0_ELECTION=$(cd ~/ton-keys/elections && echo 0 > active-election-id && echo 0 > election-id)
ACTIVE_ELECTION_ID=$(cd ~/net.ton.dev/ton/build/lite-client && ./lite-client -p ~/ton-keys/liteserver.pub -a 127.0.0.1:3031 -rc 'getconfig 34' -rc 'quit' 2>/dev/null | grep time | awk '{print $3}' | tr -d 'utime_until:')
ECHO_ID_ELECTION=$(cd ~/ton-keys/elections && echo $ACTIVE_ELECTION_ID > active-election-id && echo $ACTIVE_ELECTION_ID > election-id)

#balance
#2 - get my account info
MY_ACCOUNT=$(cd ~/net.ton.dev/ton/build/lite-client && ./lite-client -p ~/ton-keys/liteserver.pub -a 127.0.0.1:3031 -rc "getaccount ${MY_RAW_ADDRESS}" -rc 'quit' 2>/dev/null)
#3 - grep balance
MY_BALANCE=$(echo "$MY_ACCOUNT" | tail -n 1 | tr -d '=''ng' | awk '{print $4}')


BALANCE_BY='1000000000000'
BALANCE=$(echo $MY_BALANCE-$BALANCE_BY-10000000000 | bc -l)
STAKE="$(($RANDOM% $BALANCE_BY+$BALANCE))"

#command
submitTransaction=$(cd ~/net.ton.dev/tonos-cli/target/release && ./tonos-cli call "$MY_RAW_ADDRESS" submitTransaction "{"\"dest"\":"\"-1:3333333333333333333333333333333333333333333333333333333333333333"\","\"value"\":"$STAKE","\"bounce"\":false,"\"allBalance"\":false,"\"payload"\":"\"$BOC"\"}" --abi ~/net.ton.dev/configs/SafeMultisigWallet.abi.json --sign ~/ton-keys/msig.keys.json)

$ECHO_0_ELECTION && $submitTransaction >> ~/node.operator/logs/validator.log && $ECHO_ID_ELECTION
