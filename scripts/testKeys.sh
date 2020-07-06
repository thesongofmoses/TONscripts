#!/bin/bash

. ~/node.operator/configs/scripts.config

TEST_VALIDATION_PREVIOUS_ADNL_KEY=$(echo "${GETCONFIG32}" | grep $PREVIOUS_ADNL_KEY | awk '{print $4}' | tr -d ')' | tr -d 'adnl_addr:x')

if [ "$NEW_ADNL_KEY" == "$DIR_ELECTION_ADNL_KEY" ];
then
        echo "new adnl key is dir election adnl key"
else
        echo "new adnl key is NOT dir election adnl key"
fi

if [ "$TEST_VALIDATION_PREVIOUS_ADNL_KEY" == "$PREVIOUS_ADNL_KEY" ];
then
        echo "past adnl key is n-3
else
        echo "try n-4?"
fi
