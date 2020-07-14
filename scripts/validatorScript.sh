#!/bin/bash

. ~/node.operator/configs/scripts.config

#variables
BALANCE_BY='10'
SLEEP_BY='200'
FEES_RESERVE='1'

BALANCE=$(echo $MY_BALANCE-$BALANCE_BY-$FEES_RESERVE | bc -l)
ROUNDED_BALANCE=$(printf "%.0f" $BALANCE)

SLEEP="$(($RANDOM% $SLEEP_BY+300))"
STAKE="$(($RANDOM% $BALANCE_BY+$ROUNDED_BALANCE))"

sleep $SLEEP && cd ~/net.ton.dev/scripts && ./validator_msig.sh $STAKE >> ~/node.operator/logs/validator.log
