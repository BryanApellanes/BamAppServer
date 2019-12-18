#!/bin/bash


if [[ -d ci ]]; then
    echo yay
fi 

if [[ !(-d notthere) ]]; then
    echo "not there"
fi