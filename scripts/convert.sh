#!/bin/bash

permkey_hash=$(cat /var/ton-work/db/config.json | jq -r ".validators[0].id" | base64 -d | xxd -p -c 64)
tempkey_hash=$(cat /var/ton-work/db/config.json | jq -r ".validators[0].temp_keys[0].key" | base64 -d | xxd -p -c 64)
adnlkey_hash=$(cat /var/ton-work/db/config.json | jq -r ".validators[0].adnl_addrs[0].id" | base64 -d | xxd -p -c 64)

echo "permkey_hash: $permkey_hash"
echo "tempkey_hash: $tempkey_hash"
echo "adnlkey_hash: $adnlkey_hash"
