#!/bin/bash

killall -9 validator-engine \
killall -9 validator-engine-console \
cd ~/net.ton.dev/scripts/ && \
export NETWORK_TYPE="${1}" && \ 
./setup.sh && \ 
./run.sh && \
sleep 5 && \ 
./check_node_sync_status.sh
