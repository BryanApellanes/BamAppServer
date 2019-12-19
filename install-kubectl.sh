#!/bin/bash

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: install-kubectl.sh\r\n"
    printf "\r\n"
    printf "Installs kubctl using apt-get."
    printf "\r\n"
    exit 0;
fi

apt-get update && apt-get install -y apt-transport-https jq
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
apt-get update
apt-get install -y kubectl --allow-unauthenticated