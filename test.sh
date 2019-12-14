#!/bin/bash

TAG=$(<tag)

if [[ -z $TAG ]]; then
    printf "yo\r\n"
fi

let "VER = $TAG + 1"

printf $VER