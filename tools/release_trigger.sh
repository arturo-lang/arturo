#!/usr/bin/env bash

set -e

if [ $# -lt 2 ]; then
    echo "Usage: $0 <version> <codename> [test]"
    echo "Example: $0 0.10.0 'Arizona Bark'"
    echo "         $0 0.10.0 'Arizona Bark' test"
    exit 1
fi

VERSION="$1"
CODENAME="$2"
TEST_MODE="${3:-}"

if [ "$TEST_MODE" = "test" ]; then
    COMMIT_MSG="Test pre-release $VERSION \"$CODENAME\""
    MODE_LABEL="TEST"
else
    COMMIT_MSG="Release $VERSION \"$CODENAME\""
    MODE_LABEL="PRODUCTION"
fi

echo ""
echo " |=================================================================="
echo " | Arturo   | Release > Trigger"
echo " |=================================================================="
echo " | Version  : $VERSION"
echo " | Codename : $CODENAME"
echo " | Tag      : v$VERSION"
echo " | MODE     : $MODE_LABEL" 
echo " |=================================================================="
echo ""

read -p " Proceed with release? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo " Aborted."
    exit 1
fi

echo " - Pulling changes..."
git pull origin master

echo ""
echo " - Updating version files..."
echo "$VERSION" > version/version
echo "$CODENAME" > version/codename
echo "0" > version/revision
echo "" > version/metadata

echo " - Committing changes..."
git add version/*
git commit -m "$COMMIT_MSG"
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