#!/bin/bash

HOSTNAME=$(cat /etc/hostname)

#variables
MY_RAW_ADDRESS=$(cat ~/ton-keys/$HOSTNAME.addr)
BOC=$(cd ~/ton-keys/elections && echo $(base64 --wrap=0 "recover-query.boc"))

STAKE='1000000000'

#command
submitTransaction=$(cd ~/net.ton.dev/tonos-cli/target/release && ./tonos-cli call "$MY_RAW_ADDRESS" submitTransaction "{"\"dest"\":"\"-1:3333333333333333333333333333333333333333333333333333333333333333"\","\"value"\":"$STAKE","\"bounce"\":true,"\"allBalance"\":false,"\"payload"\":"\"$BOC"\"}" --abi ~/net.ton.dev/configs/SafeMultisigWallet.abi.json --sign ~/ton-keys/msig.keys.json >> ~/node.operator/logs/validator.log)

$submitTransaction
