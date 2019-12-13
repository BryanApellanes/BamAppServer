#!/bin/bash

echo $TESTVALUE

if [[ -z $TESTVALUE ]]; then
    echo "it was blank"
fi

input="./imageregistries/creds/azure"
while IFS= read -r line
do
  echo "$line"
done < "$input"