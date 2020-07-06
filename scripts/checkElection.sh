#!/bin/bash

. ~/node.operator/configs/scripts.config

# check validation status
if [ "$CHECK_ELECTION_STATUS" == 0 ] && [ "$CHECK_TRANSITION_STATUS" == "(null)" ];
then
        if [ "$CHECK_VALIDATION_STATUS_NEW_ADNL_KEY" == "$NEW_ADNL_KEY" ];
        then
                printf "${CYAN}--------CURRENTLY VALIDATING--------\n"
                printf "Validation until: "
                printf "$CURRENT_VALIDATION_UNTIL_HUMANTIME\n"
                printf "Next election at: "
                printf "$CURRENT_ELECTION_SINCE_HUMANTIME\n"
                printf "Rewards earned so far: "
                printf "$CURRENT_MY_BONUS\n"
                printf "Recoverable at: "
                printf "$NEXT_ELECTION_SINCE_HUMANTIME${NO_COLOR}\n"
                printf "${YELLOW}Next election begins: "
                printf "$CURRENT_ELECTION_SINCE_HUMANTIME${NO_COLOR}\n"
        else
                printf "${RED}--------CURRENTLY NOT VALIDATING--------\n"
                printf "This error could've been caused by unmatching ADNL record${NO_COLOR}\n"
                printf "${YELLOW}Next election begins: "
                printf "$CURRENT_ELECTION_SINCE_HUMANTIME${NO_COLOR}\n"
        fi
fi

if [ "$CHECK_ELECTION_STATUS" != 0 ];
then
        if [ "$CHECK_VALIDATION_STATUS_PREVIOUS_ADNL_KEY" == "$PREVIOUS_ADNL_KEY" ];
        then
                printf "${CYAN}--------CURRENTLY VALIDATING--------\n"
                printf "Validation Until: "
                printf "$CURRENT_VALIDATION_UNTIL_HUMANTIME\n"
                printf "Next Election At: "
                printf "$CURRENT_ELECTION_SINCE_HUMANTIME\n"
                printf "Rewards Earned: "
                printf "$CURRENT_MY_BONUS_TRANSITION\n"
                printf "Recoverable At: "
                printf "$NEXT_ELECTION_SINCE_HUMANTIME${NO_COLOR}\n"
                printf "${YELLOW}Next Election At: "
                printf "$CURRENT_ELECTION_SINCE_HUMANTIME${NO_COLOR}\n"
        else
                printf "${RED}--------CURRENTLY NOT VALIDATING--------\n"
                printf "This error could've been caused by unmatching ADNL record${NO_COLOR}\n"
                printf "${YELLOW}Next Election At: "
                printf "$CURRENT_ELECTION_SINCE_HUMANTIME${NO_COLOR}\n"
        fi
fi

if [ "$CHECK_TRANSITION_STATUS" != "(null)" ];
then
        if [ "$CHECK_VALIDATION_STATUS_PREVIOUS_ADNL_KEY" == "$PREVIOUS_ADNL_KEY" ];
        then
                printf "${CYAN}--------CURRENTLY VALIDATING--------\n"
                printf "Validation Until: "
                printf "$CURRENT_VALIDATION_UNTIL_HUMANTIME\n"
                printf "Next Election At: "
                printf "$CURRENT_ELECTION_SINCE_HUMANTIME\n"
                printf "Rewards Earned: "
                printf "$CURRENT_MY_BONUS_TRANSITION\n"
                printf "Recoverable At: "
                printf "$NEXT_ELECTION_SINCE_HUMANTIME${NO_COLOR}\n"
                printf "${YELLOW}Next Election At: "
                printf "$CURRENT_ELECTION_SINCE_HUMANTIME${NO_COLOR}\n"
        else
                printf "${RED}--------CURRENTLY NOT VALIDATING--------\n"
                printf "This error could've been caused by unmatching ADNL record${NO_COLOR}\n"
                printf "${YELLOW}Next Election At: "
                printf "$CURRENT_ELECTION_SINCE_HUMANTIME${NO_COLOR}\n"
        fi
fi


##### how to if election started so adnl key changed but want to check if currently validating

#2 check election status
## during election
if [ "$CHECK_ELECTION_STATUS" != 0 ];
then
        if [ "$CHECK_ELECTION_SUBMISSION" != 0 ];
        then
                printf "${GREEN}----------SUBMISSION CONFIRMED----------\n"
                printf "Election ID: "
                printf "$CURRENT_ACTIVE_ELECTION_ID\n"
                printf "Staked Tokens: "
                printf "$NEXT_MY_STAKED_TOKENS$\n"
                printf "Expected Reward Stake: "
                printf "$EXPECTED_MY_TOTAL_BONUS\n"
                printf "Expected Interest Rate: "
                printf "$EXPECTED_INTEREST_RATE\n"
                printf "Recoverable At: "
                printf "$NEXT_ELECTION_SINCE_HUMANTIME${NO_COLOR}\n"
                printf "Election Result At: "
                printf "$CURRENT_ELECTION_UNTIL_HUMANTIME${NO_COLOR}\n"

        elif [ "$CHECK_ELECTION_SUBMISSION" == 0 ];
        then
                printf "${RED}---------SUBMISSION UNCONFIRMED---------\n"
                printf "WARNING: NO STAKES FOUND\n"
                printf "Election ID: "
                printf "$CURRENT_ACTIVE_ELECTION_ID"
                printf "Election Until: "
                printf "$CURRENT_ELECTION_UNTIL_HUMANTIME${NO_COLOR}\n"
        fi
fi

## after election ends
if [ "$CHECK_ELECTION_STATUS" == 0 ];
then
        if [ "$CHECK_ELECTION_RESULT" == "$NEW_ADNL_KEY" ];
        then
                printf "${GREEN}-----------ELECTED VALIDATOR-----------\n"
                printf "Election Result: SUCCESS\n"
                printf "Validation Starts: "
                printf "$NEXT_VALIDATION_SINCE_HUMANTIME${NO_COLOR}\n"
                printf "${YELLOW}Next Election At: "
                printf "$NEXT_ELECTION_SINCE_HUMANTIME${NO_COLOR}\n"

        elif [ "$CHECK_ELECTION_RESULT" != "$NEW_ADNL_KEY" ] && [ "$CHECK_TRANSITION_STATUS" != "(null)" ];
        then
                printf "${RED}-----------ELECTION FAILED----------${NO_COLOR}\n"
                printf "Stakes Held Until"
                printf "$CURRENT_ELECTION_UNTIL_HUMANTIME"
                printf "Next Election At: "
                printf "$NEXT_ELECTION_SINCE_TIME"
        fi
fi
