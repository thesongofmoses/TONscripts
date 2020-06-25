#!/bin/bash

#1 - get the custodian key stored in ton-keys dir
HALF_PUBKEY=$(cat ~/ton-keys/msig.keys.json | grep 'public' | awk '{print $2}' | tr -d '"' | tr -d ',')
FULL_PUBKEY=$(printf "0x%s" "$HALF_PUBKEY")

#2 - deploy wallet with the custodian key from #1 with fullpaths for all necessary files and reqConfirm:1
function deployWallet () {
        cd ~/net.ton.dev/tonos-cli/target/release/ && ./tonos-cli deploy ~/net.ton.dev/ton-labs-contracts/solidity/safemultisig/SafeMultisigWallet.tvc "{"\"owners"\":["\"$FULL_PUBKEY"\"],"\"reqConfirms"\":1}" --abi ~/net.ton.dev/ton-labs-contracts/solidity/safemultisig/SafeMultisigWallet.abi.json --sign ~/ton-keys/msig.keys.json --wc -1
}

deployWallet
