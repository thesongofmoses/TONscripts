#!/bin/bash

CHECK_ENGINE=$(pgrep validator)
PRINT_UNIXTIME=$(date +%s)

function RESTART () {
        printf '%u\n' "$PRINT_UNIXTIME" && \
        cd ~/net.ton.dev/scripts/ && \
        ./run.sh
}

#if there is no validator-engine process, then execute run.sh
if [ -z "$CHECK_ENGINE" ]; then
        RESTART >> ~/ton-logs/restart.log
fi
