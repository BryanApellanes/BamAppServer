# Vimly-Admin

Vimly-Admin provides an administrative interface to the quoting system and related services.

## Prerequisites
Vimly-Admin development requires nodejs and git
- [NodeJS](https://nodejs.org/)
- [Git](https://git-scm.com/downloads)

## Quick Start

To run vimly-admin locally for development do the following:

1. create a folder to hold a local copy of the `vimly-admin` repository, change directories into it, this example uses `/src`: <br />
    `mdkir /src` <br />
    `cd /src`
2. clone the `vimly-admin` repository:<br />
    `git clone git@bitbucket.org:bsiprojectjedan/vimly-admin.git`
3. execute the `setup.sh` script, this installs the supporting toolkit:
    `./setup.sh`
4. add the following entry to your /etc/hosts file:
    `127.0.0.1    vimly-admin`
4. execute the `serve.sh` script, this starts the application listening on port 80

