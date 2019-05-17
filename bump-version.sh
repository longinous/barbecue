#!/usr/bin/env bash
#
# Usage: ./bump-version.sh <new-version>

VERSION=$1

# COLORS
RESET='\033[0m'
GREEN='\033[0;32m'
RED='\033[0;31m'

printStatus() {
    if [ $1 -ne 0 ]
    then
        echo -e " [${RED}KO${RESET}]"
        exit $1
    fi
    echo -e " [${GREEN}OK${RESET}]"
}

echo -n "Bumping to version ${VERSION}..."
./mvnw versions:set versions:commit -DnewVersion=${VERSION} &> /dev/null
printStatus $?

echo -n "Committing pom files..."
git add ./\*pom.xml &> /dev/null
git commit -m "[BBQ] Bump to version ${VERSION}" &> /dev/null
printStatus $?

echo -n "Tagging version ${VERSION}..."
git tag -a ${VERSION} -m "${VERSION}" &> /dev/null
printStatus 0
