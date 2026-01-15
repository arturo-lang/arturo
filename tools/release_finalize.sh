#!/usr/bin/env bash

set -e

if [ $# -lt 1 ]; then
    echo ""
    echo " Usage: $0 <next_dev_version>"
    echo " Example: $0 0.10.1"
    echo ""
    exit 1
fi

NEXT_VERSION="$1"

# Ensure it has -dev suffix
if [[ ! "$NEXT_VERSION" == *"-dev" ]]; then
    NEXT_VERSION="${NEXT_VERSION}-dev"
fi

echo ""
echo " |=================================================================="
echo " | Arturo   | Release > Finalize"
echo " |=================================================================="
echo " | Next dev :  $NEXT_VERSION"
echo " |=================================================================="
echo ""

read -p " Proceed? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo " Aborted."
    exit 1
fi

echo " - Pulling changes..."
git pull origin master

echo ""
echo " - Updating version files..."
echo "$NEXT_VERSION" > version/version
echo "" > version/codename
echo "1" > version/revision
echo "" > version/metadata

echo " - Committing changes..."
git add version/*
git commit -m "Bump to $NEXT_VERSION"

echo " - Pushing to remote..."


echo ""
echo " ------------------------------------------------------"
echo "  ✅ Bumped to $NEXT_VERSION"
echo " ------------------------------------------------------"
echo ""