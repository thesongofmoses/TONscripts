#!/bin/bash

. ~/node.operator/configs/scripts.config

if [ "$NEW_ADNL_KEY" == "$DIR_ELECTION_ADNL_KEY" ];
then
        echo "new adnl key is dir election adnl key"
else
        echo "new adnl key is NOT dir election adnl key"
fi

if [ "$CHECK_VALIDATION_STATUS_PREVIOUS_ADNL_KEY" == "$PREVIOUS_ADNL_KEY" ];
then
        echo "past adnl key is n-3"
else
        echo "try n-4?"
fi
