#!/bin/bash

MAJOR=$(<major)
MINOR=$(<minor)
PATCH=$(<patch)

CURRENTVERSION=$(<version)
COMMIT=$(git log --format="%H" -n 1 | cut -c 1-6)    

if [[ -z $1 || $1 = "release" || $2 = "release" ]]; then
    let "PATCH = $PATCH + 1"
fi

if [[ $1 = "major" || $2 = "major" ]]; then
    let "MAJOR = $MAJOR + 1"
fi

if [[ $1 = "minor" || $2 = "minor" ]]; then
    let "MINOR = $MINOR + 1"
fi

if [[ $1 = "patch" || $1 = "hotfix" || $2 = "patch" || $2 = "hotfix" ]]; then
    let "PATCH = $PATCH + 1"
fi

if [[ $1 = "dev" || $2 = "dev" ]]; then
    NEWVERSION=${MAJOR}.${MINOR}.${PATCH}-${COMMIT}
fi

if [[ $1 = "pre-release" || $1 = "pre" || $2 = "pre" || $2 = "pre-release" ]]; then    
    NEWVERSION=${MAJOR}.${MINOR}.${PATCH}-rc${COMMIT}
fi

if [[ -z $NEWVERSION ]]; then
    NEWVERSION=${MAJOR}.${MINOR}.${PATCH}
fi

printf "\r\n"
printf "OLD version $CURRENTVERSION\r\n"
printf "NEW version $NEWVERSION\r\n"
printf "\r\n"

echo $NEWVERSION > version

echo $MAJOR > major
echo $MINOR > minor
echo $PATCH > patch