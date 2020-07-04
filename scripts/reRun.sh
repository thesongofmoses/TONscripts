#!/bin/bash

killall -9 validator-engine \
killall -9 validator-engine-console \
cd ~/net.ton.dev/scripts && \
./run.sh && \
sleep 5 && \
./chekc_node_sync_status.sh
