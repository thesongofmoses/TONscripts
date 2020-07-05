#!/bin/bash

. ~/node.operator/configs/scripts.config

cd ~/net.ton.dev/tonos-cli/target/release/ && \
./tonos-cli \
call $MY_RAW_ADDRESS \
submitTransaction "{"\"dest"\":"\"${1}"\","\"value"\":${2},"\"bounce"\":true,"\"allBalance"\":false,"\"payload"\":"\""\"}" \
--abi ~/net.ton.dev/ton-labs-contracts/solidity/safemultisig/SafeMultisigWallet.abi.json \
--sign ~/ton-keys/msig.keys.json \
