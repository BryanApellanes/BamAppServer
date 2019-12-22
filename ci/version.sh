#!/bin/bash

if [[ $1 = "-help" ]] || [[ $1 = "-?" ]] || [[ $1 = "-h" ]]; then
    printf "usage: version.sh [ major | minor | patch ] [ dev (default) | staging | release ]\r\n"
    printf "\r\n"
    printf "Updates the current version of this project.  Version components are found in\r\n"
    printf "the semver folder in the files 'major', 'minor' and 'patch' with the full version \r\n"
    printf "found in the file 'version'.\r\n"
    printf "\r\n"
    printf "The version component specified is incremented by one.\r\n\r\n"
    printf "Specifying dev, staging or release has the following effects:\r\n\r\n"
    printf "dev - A dash (-) and the first 6 characters of the git commit are appended.\r\n\r\n"
    printf "\texample: 0.0.1-af5723\r\n\r\n"
    printf "staging - The characers "-rc_", followed by the first 6 characters of the git commit are appended.\r\n\r\n"
    printf "\texample: 0.0.1-rc_af5723\r\n\r\n"
    printf "release - No additional suffix is added.\r\n\r\n"
    printf "\texample: 0.0.1\r\n"
    printf "\r\n"
    printf "To reset the version, update the appropriate file in the semver folder.\r\n\r\n"
    printf "\texample: echo 1 > ./semver/patch\r\n"
    printf "\r\n"
    exit 0;
fi

source ./env.sh

MAJOR=$(<${SEMVERROOT}/major)
MINOR=$(<${SEMVERROOT}/minor)
PATCH=$(<${SEMVERROOT}/patch)

CURRENTVERSION=$(<${SEMVERROOT}/version)

if [[ $1 = "show" ]]; then
    echo ${CURRENTVERSION}
    exit 0
fi

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