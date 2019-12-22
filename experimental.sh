#!/bin/bash

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: experimental.sh\r\n"
    printf "\r\n"
    printf "This script is used as a one off adhoc testing script, this help text should remain to let the next\r\n"
    printf "person to review this script know intent; content may be anything necessary for a one off test.\r\n"
    printf "\r\n"
    exit 0
fi

echo "You are in the ${PWD##*/} context"