#!/usr/bin/env bash

set -e

if [ $# -lt 2 ]; then
    echo "Usage: $0 <version> <revision>"
    echo "Example: $0 0.10.0-dev 3457"
    exit 1
fi

VERSION="$1"
REVISION="$2"

echo ""
echo " |=================================================================="
echo " | Arturo   | Release > Undo"
echo " |=================================================================="
echo ""

read -p " Proceed with cleaning pre-release? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo " Aborted."
    exit 1
fi

echo ""
echo " - Updating version files..."
echo "$VERSION" > version/version
echo "" > version/codename
echo "$REVISION" > version/revision
echo "" > version/metadata

echo " - Pulling changes..."
git pull origin master

echo " - Committing changes..."
git add version/*
git commit -m "Restore values"
echo " - Tagging release..."

echo " - Pushing to remote..."
git push origin master

echo ""
echo " ------------------------------------------------------"
echo "  ✅ Release cleaned!"
echo " ------------------------------------------------------"
echo ""
