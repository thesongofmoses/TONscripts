#!/bin/bash

#delete existing dirs
sudo rm -rf /var/ton-work \
rm -rf ~/ton-keys \
rm -rf ~/net.ton.dev \

#build
sudo apt-get update -y && \
sudo apt-get full-upgrade -y && \
cd && git clone https://github.com/tonlabs/net.ton.dev.git && \
cd net.ton.dev/scripts && \
. ./env.sh && \
./build.sh && \
export NETWORK_TYPE="${1}" && \
./setup.sh && \
./run.sh && \

#set configs for tonos-cli
cd ~/net.ton.dev/tonos-cli/target/release/ && ./tonos-cli config --url https://"${1}".ton.dev --wc -1 && \
cp ~/net.ton.dev/tonos-cli/target/release/tonlabs-cli.conf.json ~/net.ton.dev/scripts/tonlabs-cli.conf.json \
