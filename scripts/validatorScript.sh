#!/bin/bash

. ~/node.operator/configs/scripts.config

#variables
BALANCE_BY='5'
FEES_RESERVE='2'
SLEEP_BY='180'
SLEEP_DELAY='60'

BALANCE=$(echo $MY_BALANCE-$BALANCE_BY-$FEES_RESERVE | bc -l)
ROUNDED_BALANCE=$(printf "%.0f" $BALANCE)

SLEEP="$(($RANDOM% $SLEEP_BY+$SLEEP_DELAY))"
STAKE="$(($RANDOM% $BALANCE_BY+$ROUNDED_BALANCE))"

if [ $CHECK_ELECTION_STATUS != 0 ];
then
        sleep $SLEEP && cd ~/net.ton.dev/scripts && ./validator_msig.sh $STAKE >> ~/node.operator/logs/validator.log
fi
