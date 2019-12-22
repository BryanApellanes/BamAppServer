#!/bin/bash

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]
then
    printf "usage: source setup.sh\r\n"
    printf "\r\n"
    printf "Build and install the bam toolkit from source.\r\n"
    printf "\r\n"
    exit 0
fi

if [[ $_ != $0 ]]
    then        
        git submodule update --init --recursive

        cd Workspace/BamToolkit/
        source ./setup.sh

        cd ../../
        npm install
else
    printf "\r\nPlease source this file to ensure your PATH variable is properly updated.\r\n\r\n"
    printf "source ./setup.sh\r\n\r\n"
fi
