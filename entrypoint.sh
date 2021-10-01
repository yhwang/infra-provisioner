#!/bin/sh -l

echo "GIBHUB_SHA:$GITHUB_SHA"
echo "GIBHUB_REF:$GITHUB_REF"
echo "GITHUB_REPOSITORY:$GITHUB_REPOSITORY"
echo "filename:$6"

if ibmcloud login --apikey "$1" --no-region -q \
    && ibmcloud target -r "$2" -o "$3" -s "$4" -g "$5" -q; then
    echo "login successfully"
else
    exit 1
fi

curl -H "Accept: application/vnd.github.v3+json" \
  "https://api.github.com/repos/$GITHUB_REPOSITORY/commits/$GITHUB_SHA" | jq '.files'
