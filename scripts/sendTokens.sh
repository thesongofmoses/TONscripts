#!/bin/bash

CHECK_RECIPIENT_ACCOUNT=$(cd ~/net.ton.dev/ton/build/lite-client && ./lite-client -p ~/ton-keys/liteserver.pub -a 127.0.0.1:3031 -rc "getaccount ${1}" -rc 'quit' 2>/dev/null | grep account | awk 'FNR == 3 {print $1}' | perl -ne '/state:\(account_(\S+)/ && print $1')

if [ "$CHECK_RECIPIENT_ACCOUNT" == 'active' ];
then
        cd ~/net.ton.dev/tonos-cli/target/release/ && \
        ./tonos-cli \
        call $MY_RAW_ADDRESS \
        submitTransaction "{"\"dest"\":"\"${1}"\","\"value"\":${2},"\"bounce"\":true,"\"allBalance"\":false,"\"payload"\":"\""\"}" \
        --abi ~/net.ton.dev/ton-labs-contracts/solidity/safemultisig/SafeMultisigWallet.abi.json \
        --sign ~/ton-keys/msig.keys.json
else
        cd ~/net.ton.dev/tonos-cli/target/release/ && \
        ./tonos-cli \
        call $MY_RAW_ADDRESS \
        submitTransaction "{"\"dest"\":"\"${1}"\","\"value"\":${2},"\"bounce"\":false,"\"allBalance"\":false,"\"payload"\":"\""\"}" \
        --abi ~/net.ton.dev/ton-labs-contracts/solidity/safemultisig/SafeMultisigWallet.abi.json \
        --sign ~/ton-keys/msig.keys.json
fi
