#!/bin/bash

pkill -f validator-engine
cd ~/net.ton.dev
git checkout master
git fetch --all --prune
git reset --hard origin/master
cd ~/net.ton.dev/scripts && ./build.sh
cd ~/net.ton.dev/scripts && ./run.sh
cd ~/net.ton.dev/ton
git rev-parse HEAD

#set configs for tonos-cli
cd ~/net.ton.dev/tonos-cli/target/release/ && ./tonos-cli config --url https://"${1}".ton.dev --wc -1 && \
cp ~/net.ton.dev/tonos-cli/target/release/tonlabs-cli.conf.json ~/net.ton.dev/scripts/tonlabs-cli.conf.json \

#echo node versions
echo '/ton version:' && \
cd ~/net.ton.dev/ton && git rev-parse HEAD && \
echo '/net.ton.dev version:' && \
cd ~/net.ton.dev && git rev-parse HEAD
