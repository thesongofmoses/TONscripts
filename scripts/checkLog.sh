#!/bin/bash

#0 - variables
TAIL_NUMBER='5000'

#1A - print texts
PRINT_UNIXTIME_TEXT=$(printf 'UNIX_TIME:')
PRINT_UNIXTIME_DATE=$(date +%s)
PRINT_TIME_DIFF=$(printf 'TIME_DIFF:')
PRINT_SLOW=$(printf 'SLOW:')

PRINT_NEW_BLOCK_CREATED=$(printf 'NEW_BLOCK_CREATED:')
PRINT_APPROVED_CANDIDATE=$(printf 'APPROVED_CANDIDATE:')
PRINT_REJECTED_CANDIDATE=$(printf 'REJECTED_CANDIDATE:')
PRINT_FAILED_TO_GENERATE_BLOCK_CANDIDATE=$(printf 'FAILED_TO_GENERATE_BLOCK_CANDIDATE:')
PRINT_FAILED_TO_VALIDATE_CANDIDATE=$(printf 'FAILED_TO_VALIDATE_CANDIDATE:')
PRINT_FAILED_CANDIDATE=$(printf 'FAILED_CANDIDATE:')
PRINT_FAILED_TO_GET_CANDIDATE=$(printf 'FAILED_TO_GET_CANDIDATE:')
PRINT_FAILED_TO_GET_BLOCK=$(printf 'FAILED_TO_GET_BLOCK:')

PRINT_FAILED_TO_INIT_CRYPTO=$(printf 'FAILED_TO_INIT_CRYPTO:')
PRINT_FAILED_TO_ANSWER_QUERY=$(printf 'FAILED_TO_ANSWER_QUERY:')
PRINT_INCONN=$(printf 'INCONN:')
PRINT_TIMEOUT=$(printf 'TIMEOUT:')
PRINT_LOST_PROMISE=$(printf 'LOST_PROMISE:')
PRINT_TOO_OLD=$(printf 'TOO_OLD:')
PRINT_WRONG_BLOCK_IN_OLD_ROUND=$(printf 'WRONG_BLOCK_IN_OLD_ROUND:')

PRINT_ERROR_TOTAL=$(printf 'ERROR_TOTAL:')
PRINT_ERROR_0=$(printf 'ERROR_0:')
PRINT_ERROR_603=$(printf 'ERROR_603:')
PRINT_ERROR_621=$(printf 'ERROR_621:')
PRINT_ERROR_651=$(printf 'ERROR_651:')
PRINT_ERROR_652=$(printf 'ERROR_652:')
PRINT_ERROR_653=$(printf 'ERROR_653:')
PRINT_ERROR_666=$(printf 'ERROR_-666:')
PRINT_ERROR_POSIXERROR=$(printf 'POSIXERROR')

#2A - general data and errors from node.log
CHECK_TIME_DIFF=$(~/net.ton.dev/scripts/check_node_sync_status.sh | awk 'FNR == 14 {print $4}')
COUNT_NODELOG_SLOW=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'SLOW' | wc -l)

COUNT_NODELOG_NEW_BLOCK_CREATED=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'new Block created' | wc -l)
COUNT_NODELOG_APPROVED_CANDIDATE=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'approved candidate' | wc -l)
COUNT_NODELOG_REJECTED_CANDIDATE=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'REJECTED CANDIDATE' | wc -l)
COUNT_NODELOG_FAILED_TO_GENERATE_BLOCK_CANDIDATE=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'failed to generate block candidate' | wc -l)
COUNT_NODELOG_FAILED_TO_VALIDATE_CANDIDATE=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'failed to validate candidate' | wc -l)
COUNT_NODELOG_FAILED_CANDIDATE=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'failed candidate' | wc -l)
COUNT_NODELOG_FAILED_TO_GET_CANDIDATE=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'failed to get candidate' | wc -l)
COUNT_NODELOG_FAILED_TO_GET_BLOCK=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'failed to get block' | wc -l)

COUNT_NODELOG_FAILED_TO_INIT_CRYPTO=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'failed to init crypto' | wc -l)
COUNT_NODELOG_FAILED_TO_ANSWER_QUERY=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'failed to answer query' | wc -l)
COUNT_NODELOG_INCONN=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'inconn' | wc -l)
COUNT_NODELOG_TIMEOUT=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'timeout' | wc -l)
COUNT_NODELOG_LOST_PROMISE=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'Lost promise' | wc -l)
COUNT_NODELOG_TOO_OLD=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'too old' | wc -l)
COUNT_NODELOG_WRONG_BLOCK_IN_OLD_ROUND=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'wrong block in old round' | wc -l)

COUNT_NODELOG_ERROR_TOTAL=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'Error :' | wc -l)
COUNT_NODELOG_ERROR_0=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'Error : 0' | wc -l)
COUNT_NODELOG_ERROR_603=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'Error : 603' | wc -l)
COUNT_NODELOG_ERROR_621=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'Error : 621' | wc -l)
COUNT_NODELOG_ERROR_651=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'Error : 651' | wc -l)
COUNT_NODELOG_ERROR_652=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'Error : 652' | wc -l)
COUNT_NODELOG_ERROR_653=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'Error : 653' | wc -l)
COUNT_NODELOG_ERROR_666=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'Error : -666' | wc -l)
COUNT_NODELOG_ERROR_POSIXERROR=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'PosixError' | wc -l)

#3 - execute commands
function checkLog () {
        printf '%s %u; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s\n' \
        "$PRINT_UNIXTIME_TEXT" "$PRINT_UNIXTIME_DATE" \
        "$PRINT_TIME_DIFF" "$CHECK_TIME_DIFF" \
        "$PRINT_SLOW" "$COUNT_NODELOG_SLOW" \
        "$PRINT_NEW_BLOCK_CREATED" "$COUNT_NODELOG_NEW_BLOCK_CREATED" \
        "$PRINT_APPROVED_CANDIDATE" "$COUNT_NODELOG_APPROVED_CANDIDATE" \
        "$PRINT_REJECTED_CANDIDATE" "$COUNT_NODELOG_REJECTED_CANDIDATE" \
        "$PRINT_FAILED_TO_GENERATE_BLOCK_CANDIDATE" "$COUNT_NODELOG_FAILED_TO_GENERATE_BLOCK_CANDIDATE" \
        "$PRINT_FAILED_TO_VALIDATE_CANDIDATE" "$COUNT_NODELOG_FAILED_TO_VALIDATE_CANDIDATE" \
        "$PRINT_FAILED_CANDIDATE" "$COUNT_NODELOG_FAILED_CANDIDATE" \
        "$PRINT_FAILED_TO_GET_CANDIDATE" "$COUNT_NODELOG_FAILED_TO_GET_CANDIDATE" \
        "$PRINT_FAILED_TO_GET_BLOCK" "$COUNT_NODELOG_FAILED_TO_GET_BLOCK" \
        "$PRINT_FAILED_TO_INIT_CRYPTO" "$COUNT_NODELOG_FAILED_TO_INIT_CRYPTO" \
        "$PRINT_FAILED_TO_ANSWER_QUERY" "$COUNT_NODELOG_FAILED_TO_ANSWER_QUERY" \
        "$PRINT_INCONN" "$COUNT_NODELOG_INCONN" \
        "$PRINT_TIMEOUT" "$COUNT_NODELOG_TIMEOUT" \
        "$PRINT_LOST_PROMISE" "$COUNT_NODELOG_LOST_PROMISE" \
        "$PRINT_TOO_OLD" "$COUNT_NODELOG_TOO_OLD" \
        "$PRINT_WRONG_BLOCK_IN_OLD_ROUND" "$COUNT_NODELOG_WRONG_BLOCK_IN_OLD_ROUND" \
        "$PRINT_ERROR_TOTAL" "$COUNT_NODELOG_ERROR_TOTAL" \
        "$PRINT_ERROR_0" "$COUNT_NODELOG_ERROR_0" \
        "$PRINT_ERROR_603" "$COUNT_NODELOG_ERROR_603" \
        "$PRINT_ERROR_621" "$COUNT_NODELOG_ERROR_621" \
        "$PRINT_ERROR_651" "$COUNT_NODELOG_ERROR_651" \
        "$PRINT_ERROR_652" "$COUNT_NODELOG_ERROR_652" \
        "$PRINT_ERROR_653" "$COUNT_NODELOG_ERROR_653" \
        "$PRINT_ERROR_666" "$COUNT_NODELOG_ERROR_666" \
        "$PRINT_ERROR_POSIXERROR" "$COUNT_NODELOG_ERROR_POSIXERROR"
}

checkLog >> ~/node.operator/logs/master.log
