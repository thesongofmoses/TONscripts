#!/bin/bash

. ~/node.operator/configs/scripts.config

# check validation status
if [ "$CHECK_ELECTION_STATUS" == 0 ];
then
        if [ "$CHECK_VALIDATION_STATUS" == "$DIR_ELECTION_ADNL_KEY" ];
        then
                printf "${GREEN}-----VALIDATION CONFIRMED-----\n"
                printf "Validation until: "
                printf "$CURRENT_VALIDATION_UNTIL_HUMANTIME\n"
                printf "Next election at: "
                printf "$CURRENT_ELECTION_SINCE_HUMANTIME\n"
                printf "Rewards earned so far: "
                printf "$CURRENT_MY_BONUS\n"
                printf "Recoverable at: "
                printf "$NEXT_ELECTION_SINCE_HUMANTIME${NO_COLOR}\n"
        else
                printf "${RED}You are not validating in this cycle\n"
                printf "It could be because your ADNL election key in keys dir is not right${NO_COLOR}\n"
                printf "Next election begins: "
                printf "$CURRENT_ELECTION_SINCE_HUMANTIME\n"

        fi
fi

##### how to if election started so adnl key changed but want to check if currently validating

#2 check election status
## during election
if [ "$CHECK_ELECTION_STATUS" != 0 ];
then
        if [ "$CHECK_ELECTION_SUBMISSION" != 0 ];
        then
                printf "${GREEN}------SUBMISSION CONFIRMED------\n"
                printf "Election ID: "
                printf "$CURRENT_ACTIVE_ELECTION_ID\n"
                printf "Staked Tokens: "
                printf "$STAKED_TOKENS\n"
                printf "Election result at: "
                printf "$CURRENT_ELECTION_UNTIL_HUMANTIME"
                printf "-------SUBMISSION CONFIRMED-------"
                printf "${NO_COLOR}"

        elif [ "$CHECK_ELECTION_SUBMISSION" == 0 ];
        then
                printf "${RED}----SUBMISSION UNCONFIRMED----\n"
                printf "WARNING: NO STAKES FOUND\n"
                printf "Election ID: "
                printf "$CURRENT_ACTIVE_ELECTION_ID"
                printf "ELECTION UNTIL: "
                printf "$CURRENT_ELECTION_UNTIL_HUMANTIME${NO_COLOR}\n"
        fi
fi

## after election ends
if [ "$CHECK_ELECTION_STATUS" == 0 ];
then
        if [ "$CHECK_ELECTION_RESULT" == "$DIR_ELECTION_ADNL_KEY" ];
        then
                printf "${GREEN}------ELECTED VALIDATOR------\n"
                printf "Election closed\n"
                printf "Next election opens: "
                printf "$NEXT_ELECTION_SINCE_HUMANTIME\n"
                printf "Expected Reward Stake: "
                printf "$EXPECTED_TOTAL_BONUS\n"
                printf "Expected Interest Rate: "
                printf "$EXPECTED_INTEREST_RATE\n"
                printf "Recoverable at: "
                printf "$NEXT_ELECTION_SINCE_HUMANTIME${NO_COLOR}\n"

        elif [ "$CHECK_ELECTION_RESULT" != "$DIR_ELECTION_ADNL_KEY" ] && [ "$CHECK_TRANSITION_STATUS" != "(null)" ];
        then
                printf "${RED}---------Election failed--------${NO_COLOR}\n"
                printf "Stakes held until"
                printf "$CURRENT_ELECTION_UNTIL_HUMANTIME"
                printf "Next election at: "
                printf "$NEXT_ELECTION_SINCE_TIME"
        fi
fi
