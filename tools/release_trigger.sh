#!/usr/bin/env bash

set -e

if [ $# -lt 2 ]; then
    echo "Usage: $0 <version> <codename>"
    echo "Example: $0 0.10.0 'Arizona Bark'"
    exit 1
fi

VERSION="$1"
CODENAME="$2"

echo ""
echo " |=================================================================="
echo " | Arturo   | Release > Trigger"
echo " |=================================================================="
echo " | Version  :  $VERSION"
echo " | Codename : $CODENAME"
echo " | Tag      : v$VERSION"
echo " |=================================================================="
echo ""

read -p " Proceed with release? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo " Aborted."
    exit 1
fi

echo ""
echo " - Updating version files..."
echo "$VERSION" > version/version
echo "$CODENAME" > version/codename
echo "0" > version/revision
echo "" > version/metadata

echo " - Committing changes..."
git add version/*
git commit -m "Release $VERSION \"$CODENAME\""
echo " - Tagging release..."
git tag "v$VERSION"

echo " - Pushing to remote..."
git push origin master
git push origin "v$VERSION"

echo ""
echo " ------------------------------------------------------"
echo "  ✅ Release tagged and pushed!"
echo " ------------------------------------------------------"
echo ""
echo " GitHub Actions will now build and"
echo " release Arturo $VERSION \"$CODENAME\""
echo ""
echo " Next steps:"
echo "   - Wait for release workflow to complete"
echo "   - Run tools/release_finalize.sh <NEXT_VERSION>"
echo ""