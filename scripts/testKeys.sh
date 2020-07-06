#!/bin/bash

. ~/node.operator/configs/scripts.config

if [ "$NEW_ADNL_KEY" == "$DIR_ELECTION_ADNL_KEY" ];
then
        echo "new adnl key is dir election adnl key"
else
        echo "new adnl key is NOT dir election adnl key"
fi
