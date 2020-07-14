#!/bin/bash

. ~/node.operator/configs/scripts.config

#variables
BALANCE_BY='10'
SLEEP_BY='200'
FEES_RESERVE='1'

BALANCE=$(echo "scale=0; $MY_BALANCE-$BALANCE_BY-$FEES_RESERVE" | bc -l)

SLEEP="$(($RANDOM% $SLEEP_BY+300))"
STAKE="$(($RANDOM% $BALANCE_BY+$BALANCE))"

sleep $SLEEP && cd ~/net.ton.dev/scripts && ./validator_msig.sh $STAKE >> ~/node.operator/logs/validator.log
