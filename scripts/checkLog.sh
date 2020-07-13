#!/bin/bash

#0 - VARIABLES
TAIL_NUMBER='5000'

#1A - PRINT TEXTS
##time
PRINT_UNIXTIME=$(printf 'UNIX_TIME:')
PRINT_TIME_DIFF=$(printf 'TIME_DIFF:')

##slow
PRINT_SLOW_TOTAL=$(printf 'SLOW_TOTAL:')
PRINT_SLOW_APPLYBLOCK=$(printf 'SLOW_APPLY_BLOCK:')
PRINT_SLOW_VALIDATEBLOCK=$(printf 'SLOW_VALIDATE_BLOCK:')
PRINT_SLOW_COLLATE=$(printf 'SLOW_COLLATE:')
PRINT_SLOW_TOO_LONG_BLOCK_VALIDATION=$(printf 'SLOW_TOO_LONG_BLOCK_VALIDATION:')

##hardware
PRINT_AVAILABLE_STORAGE=$(printf 'STORAGE:')

##errors
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
PRINT_TOO_OLD_KNOW_NEWER=$(printf 'TOO_OLD_KNOW_NEWER:')
PRINT_WRONG_BLOCK_IN_OLD_ROUND=$(printf 'WRONG_BLOCK_IN_OLD_ROUND:')

PRINT_ERROR_TOTAL=$(printf 'ERROR_TOTAL:')
PRINT_ERROR_0=$(printf 'ERROR_0:')
PRINT_IOERROR=$(printf 'IO_ERROR:')

PRINT_ERROR_603=$(printf 'ERROR_603:')
PRINT_ERROR_621=$(printf 'ERROR_621:')
PRINT_BAD_OVERLAY_ID=$(printf 'BAD_OVERLAY_ID')

PRINT_ERROR_651=$(printf 'ERROR_651:')
PRINT_RLDP_QUERY_FAILED=$(printf 'RLDP_QUERY_FAILED')

PRINT_ERROR_652=$(printf 'ERROR_652:')
PRINT_ADNL_QUERY_TIMEOUT=$(printf 'ADNL_QUERY_TIMEOUT')

PRINT_ERROR_653=$(printf 'ERROR_653:')
PRINT_ERROR_666=$(printf 'ERROR_-666:')
PRINT_ERROR_667=$(printf 'ERROR_-667:')
PRINT_CANNOT_GENERATE_BLOCK_CANDIDATE=$(printf 'CANNOT_GENERATE_BLOCK_CANDIDATE')

PRINT_ERROR_POSIXERROR=$(printf 'POSIXERROR:')

##validator-session
PRINT_VALIDATOR_SESSION_WARNING=$(printf 'VALIDATOR_SESSION_WARNING:')
PRINT_FAILED_AUTOMATED_VALIDITY_CHECKS=$(printf 'FAILED_AUTOMATED_VALIDITY_CHECKS')

#2A - COUNTS
##time
CHECK_UNIXTIME=$(date +%s)
CHECK_TIME_DIFF=$(~/net.ton.dev/scripts/check_node_sync_status.sh | awk 'FNR == 14 {print $4}')

##slow
COUNT_SLOW_TOTAL=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'SLOW' | wc -l)
COUNT_SLOW_APPLYBLOCK=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'name:applyblock' | wc -l)
COUNT_SLOW_VALIDATEBLOCK=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'name:validateblock' | wc -l)
COUNT_SLOW_COLLATE=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'name:collate' | wc -l)
COUNT_SLOW_TOO_LONG_BLOCK_VALIDATION=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'name:too long block validation' | wc -l)

##hardware
CHECK_AVAILABLE_STORAGE=$(df -h | awk 'FNR == 4 {print $4}')

##errors
COUNT_NEW_BLOCK_CREATED=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'new Block created' | wc -l)
COUNT_APPROVED_CANDIDATE=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'approved candidate' | wc -l)
COUNT_REJECTED_CANDIDATE=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'REJECTED CANDIDATE' | wc -l)
COUNT_FAILED_TO_GENERATE_BLOCK_CANDIDATE=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'failed to generate block candidate' | wc -l)
COUNT_FAILED_TO_VALIDATE_CANDIDATE=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'failed to validate candidate' | wc -l)
COUNT_FAILED_CANDIDATE=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'failed candidate' | wc -l)
COUNT_FAILED_TO_GET_CANDIDATE=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'failed to get candidate' | wc -l)
COUNT_FAILED_TO_GET_BLOCK=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'failed to get block' | wc -l)

COUNT_FAILED_TO_ANSWER_QUERY=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'failed to answer query' | wc -l)
COUNT_TOO_OLD_KNOW_NEWER=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'too old: we already know' | wc -l)
COUNT_WRONG_BLOCK_IN_OLD_ROUND=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'wrong block in old round' | wc -l)

COUNT_ERROR_TOTAL=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'Error :' | wc -l)
COUNT_ERROR_0=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'Error : 0' | wc -l)
COUNT_IOERROR=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'IO error' | wc -l)

COUNT_ERROR_603=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'Error : 603' | wc -l)
COUNT_ERROR_621=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'Error : 621' | wc -l)
COUNT_BAD_OVERLAY_ID=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'bad overlay_id' | wc -l)

COUNT_ERROR_651=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'Error : 651' | wc -l)
COUNT_RLDP_QUERY_FAILED=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'rldp query failed' | wc -l)

COUNT_ERROR_652=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'Error : 652' | wc -l)
COUNT_ADNL_QUERY_TIMEOUT=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'adnl query timeout' | wc -l)

COUNT_ERROR_653=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'Error : 653' | wc -l)
COUNT_ERROR_666=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'Error : -666' | wc -l)
COUNT_ERROR_667=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'Error : -667' | wc -l)
COUNT_CANNOT_GENERATE_BLOCK_CANDIDATE=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'cannot generate block candidate' | wc -l)

COUNT_ERROR_POSIXERROR=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'PosixError' | wc -l)
COUNT_INCONN=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'inconn' | wc -l)

##validator-session
COUNT_VALIDATOR_SESSION_WARNING=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'VALIDATOR_SESSION_WARNING' | wc -l)
COUNT_FAILED_AUTOMATED_VALIDITY_CHECKS=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'failed to pass automated validity checks' | wc -l)

##uncaterogized
COUNT_FAILED_TO_INIT_CRYPTO=$(tail -n $TAIL_NUMBER /var/ton-work/node.log | grep 'failed to init crypto' | wc -l)


#3 - FUNCTION
function checkLog () {
        printf '%s %u; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s; %s %s\n' \
        "$PRINT_UNIXTIME" "$CHECK_UNIXTIME" \
        "$PRINT_TIME_DIFF" "$CHECK_TIME_DIFF" \
        "$PRINT_SLOW_TOTAL" "$COUNT_SLOW_TOTAL" \
                "$PRINT_SLOW_APPLYBLOCK" "$COUNT_SLOW_APPLYBLOCK" \
                "$PRINT_SLOW_VALIDATEBLOCK" "$COUNT_SLOW_VALIDATEBLOCK" \
                "$PRINT_SLOW_COLLATE" "$COUNT_SLOW_COLLATE" \
                "$PRINT_SLOW_TOO_LONG_BLOCK_VALIDATION" "$COUNT_SLOW_TOO_LONG_BLOCK_VALIDATION" \
        "$PRINT_NEW_BLOCK_CREATED" "$COUNT_NEW_BLOCK_CREATED" \
                "$PRINT_APPROVED_CANDIDATE" "$COUNT_APPROVED_CANDIDATE" \
                "$PRINT_REJECTED_CANDIDATE" "$COUNT_REJECTED_CANDIDATE" \
                "$PRINT_VALIDATOR_SESSION_WARNING" "$COUNT_VALIDATOR_SESSION_WARNING" \
                "$PRINT_FAILED_AUTOMATED_VALIDITY_CHECKS" "$COUNT_FAILED_AUTOMATED_VALIDITY_CHECKS" \
                "$PRINT_FAILED_CANDIDATE" "$COUNT_FAILED_CANDIDATE" \
                "$PRINT_TOO_OLD_KNOW_NEWER" "$COUNT_TOO_OLD_KNOW_NEWER" \
        "$PRINT_AVAILABLE_STORAGE" "$CHECK_AVAILABLE_STORAGE" \
        "$PRINT_ERROR_TOTAL" "$COUNT_ERROR_TOTAL" \
                "$PRINT_ERROR_0" "$COUNT_ERROR_0" \
                        "$PRINT_IOERROR" "$COUNT_IOERROR" \
                        "$PRINT_FAILED_TO_GENERATE_BLOCK_CANDIDATE" "$COUNT_FAILED_TO_GENERATE_BLOCK_CANDIDATE" \
                "$PRINT_ERROR_603" "$COUNT_ERROR_603" \
                "$PRINT_ERROR_621" "$COUNT_ERROR_621" \
                        "$PRINT_BAD_OVERLAY_ID" "$COUNT_BAD_OVERLAY_ID" \
                "$PRINT_ERROR_651" "$COUNT_ERROR_651" \
                        "$PRINT_RLDP_QUERY_FAILED" "$COUNT_RLDP_QUERY_FAILED" \
                        "$PRINT_WRONG_BLOCK_IN_OLD_ROUND" "$COUNT_WRONG_BLOCK_IN_OLD_ROUND" \
                "$PRINT_ERROR_652" "$COUNT_ERROR_652" \
                        "$PRINT_ADNL_QUERY_TIMEOUT" "$COUNT_ADNL_QUERY_TIMEOUT" \
                        "$PRINT_FAILED_TO_GET_BLOCK" "$COUNT_FAILED_TO_GET_BLOCK" \
                "$PRINT_ERROR_653" "$COUNT_ERROR_653" \
                "$PRINT_ERROR_666" "$COUNT_ERROR_666" \
                        "$PRINT_FAILED_TO_VALIDATE_CANDIDATE" "$COUNT_FAILED_TO_VALIDATE_CANDIDATE" \
                "$PRINT_ERROR_667" "$COUNT_ERROR_667" \
                        "$PRINT_CANNOT_GENERATE_BLOCK_CANDIDATE" "$COUNT_CANNOT_GENERATE_BLOCK_CANDIDATE" \
                "$PRINT_ERROR_POSIXERROR" "$COUNT_ERROR_POSIXERROR" \
                        "$PRINT_INCONN" "$COUNT_INCONN" \
        "$PRINT_FAILED_TO_INIT_CRYPTO" "$COUNT_FAILED_TO_INIT_CRYPTO"
}

checkLog >> ~/node.operator/logs/master.log
