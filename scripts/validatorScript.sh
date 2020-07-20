#!/bin/bash

. ~/node.operator/configs/scripts.config

#variables
FEES_RESERVE='1'
SLEEP_BY='180'
SLEEP_DELAY='90'

BALANCE=$(echo $MY_BALANCE-$FEES_RESERVE | bc -l)
STAKE=$(printf "%.0f" $BALANCE)

SLEEP="$(($RANDOM% $SLEEP_BY+$SLEEP_DELAY))"

if [ $CHECK_ELECTION_STATUS != 0 ];
then
        sleep $SLEEP && cd ~/net.ton.dev/scripts && ./validator_msig.sh $STAKE >> ~/node.operator/logs/validator.log
fi
