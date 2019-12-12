#!/bin/bash

MAJOR=$(<major)
MINOR=$(<minor)
PATCH=$(<patch)

CURRENTVERSION=$(<version)

if [[ -z $1 ]]; then
    let "PATCH = $PATCH + 1"
else
    if [[ $1 = "major" ]]; then
        let "MAJOR = $MAJOR + 1"
    fi

    if [[ $1 = "minor" ]]; then
        let "MINOR = $MINOR + 1"
    fi

    if [[ $1 = "patch" ]]; then
        let "PATCH = $PATCH + 1"
    fi
fi

NEWVERSION=${MAJOR}.${MINOR}.${PATCH}

printf "\r\n"
printf "OLD version $CURRENTVERSION\r\n"
printf "NEW version $NEWVERSION\r\n\r\n"

echo $NEWVERSION > version

echo $MAJOR > major
echo $MINOR > minor
echo $PATCH > patch