#!/bin/bash

cd ~/net.ton.dev/tonos-cli/target/release/ && ./tonos-cli config --url https://"${1}".ton.dev --wc -1 && \
cp ~/net.ton.dev/tonos-cli/target/release/tonlabs-cli.conf.json ~/net.ton.dev/scripts/tonlabs-cli.conf.json \
