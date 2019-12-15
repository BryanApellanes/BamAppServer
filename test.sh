#!/bin/bash

VAL=""

if [[ -z $VAL ]]; then
    echo $VAL is blank
fi

VAL="value"

if [[ !(-z $VAL) ]]; then
    echo $VAL got it
fi

VAL=""
if [[ !(-z $VAL) ]]; then
    echo "should not see this"
fi