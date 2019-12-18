# Vimly-Admin

Vimly-Admin provides an administrative interface to the quoting system and related services.

## Prerequisites
Vimly-Admin development requires nodejs and git. <br />
- [NodeJS](https://nodejs.org/) <br />
- [Git](https://git-scm.com/downloads) <br />

## Quick Start

To prepare and run vimly-admin locally do the following:

1. create a folder to hold a local copy of the `vimly-admin` repository and change directories into it, this example uses `/src`: <br />
    `mdkir /src` <br />
    `cd /src`
2. clone the `vimly-admin` repository:<br />
    - ensure your ssh public key is trusted by the [bitbucket repository](https://bitbucket.org/bsiprojectjedan/vimly-admin/admin/access-keys/) and execute the following:<br />
    `git clone git@bitbucket.org:bsiprojectjedan/vimly-admin.git`
    - alternatively use https:<br />
    `git clone https://bitbucket.org/bsiprojectjedan/vimly-admin.git`
3. change directories into the newly cloned repository and execute the setup.sh script, this installs the supporting toolkit: <br />
    `cd vimly-admin`<br />
    `./setup.sh`
5. add the following entry to your `/etc/hosts` file:<br />
    `127.0.0.1    vimly-admin`
6. execute the 'serve.sh' script, this starts the application listening on port 80:<br />
    `./serve.sh`
7. using a browser, open `http://vimly-admin`

## Developer Workflow

The following scripts are used to facilitate developer workflow:

- clean
- build
- debug
- push
- test
- deploy

