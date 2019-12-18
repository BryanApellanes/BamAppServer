#!/bin/bash

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: version.sh [ major | minor | patch ] [ staging | release ]\r\n"
    printf "\r\n"
    printf "Updates the current version of this project.  Version components are found in the semver folder in the files 'major', 'minor' and 'patch' with the\r\n"
    printf "full version found in the file 'version'.\r\n"
    printf "\r\n"
    exit 0;
fi

source ./env.sh

MAJOR=$(<${SEMVERROOT}/major)
MINOR=$(<${SEMVERROOT}/minor)
PATCH=$(<${SEMVERROOT}/patch)

CURRENTVERSION=$(<${SEMVERROOT}/version)
COMMIT=$(git log --format="%H" -n 1 | cut -c 1-6)    

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

if [[ $1 = "pre-release" || $1 = "staging" || $2 = "staging" || $2 = "pre-release" ]]; then    
    NEWVERSION=${MAJOR}.${MINOR}.${PATCH}-rc_${COMMIT}
fi

if [[ $1 = "release" ]]; then
    NEWVERSION=${MAJOR}.${MINOR}.${PATCH}
fi

if [[ -z $NEWVERSION ]]; then
    NEWVERSION=${MAJOR}.${MINOR}.${PATCH}-${COMMIT}
fi

printf "\r\n"
printf "OLD version $CURRENTVERSION\r\n"
printf "NEW version $NEWVERSION\r\n"
printf "\r\n"

echo $NEWVERSION > ${SEMVERROOT}/version

echo $MAJOR > ${SEMVERROOT}/major
echo $MINOR > ${SEMVERROOT}/minor
echo $PATCH > ${SEMVERROOT}/patch