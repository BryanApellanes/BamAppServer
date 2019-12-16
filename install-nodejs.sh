#!/bin/bash
if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: install-nodejs.sh\r\n"
    printf "\r\n"
    printf "Downloads and installs the linux version of nodejs specified in the file 'nodeversion'.  This is used to\r\n"
    printf "install node in the container image and should not be used to install node for development;\r\n"
    printf "instead, you should use the installation method appropriate for your development environment.\r\n"
    printf "\r\n"
    exit 0;
fi

NODEVERSION=$(<nodeversion)
DISTRO=linux-x64

curl https://nodejs.org/dist/v$NODEVERSION/node-v$NODEVERSION-$DISTRO.tar.xz --output ./node-v$NODEVERSION-$DISTRO.tar.xz
mkdir -p /usr/local/lib/nodejs
tar -xvf ./node-v$NODEVERSION-$DISTRO.tar.xz -C /usr/local/lib/nodejs
ln -s /usr/local/lib/nodejs/node-v$NODEVERSION-$DISTRO/bin/node /usr/local/bin/node
ln -s /usr/local/lib/nodejs/node-v$NODEVERSION-$DISTRO/bin/npm /usr/local/bin/npm
ln -s /usr/local/lib/nodejs/node-v$NODEVERSION-$DISTRO/bin/npx /usr/local/bin/npx

chmod +x /u