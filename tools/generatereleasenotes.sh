#!/bin/bash
set -e

# Arguments
PREV_TAG=$1
CURR_TAG=$2
VERSION=$3
CODENAME=$4
COMMIT_SHA=$5
COMMIT_SHORT=$6

echo "Generating release notes from $PREV_TAG to $CURR_TAG"

# Get the date of the previous tag
PREV_DATE=$(git log -1 --format=%ai $PREV_TAG)

echo "Getting PRs merged after: $PREV_DATE"

# Get PRs merged AFTER the previous tag date and generate changelog
gh pr list --state merged --base master --limit 1000 --json number,mergedAt,title,labels | \
  jq --arg prev_date "$PREV_DATE" -r '
    .[] | 
    select(.mergedAt > $prev_date) |
    select(.labels | map(.name) | (contains(["new feature"]) or contains(["bug"]) or contains(["enhancement"]))) |
    if (.labels | map(.name) | contains(["new feature"])) then
      "FEATURE|\(.title) (#\(.number))"
    elif (.labels | map(.name) | contains(["bug"])) then
      "BUG|\(.title) (#\(.number))"
    elif (.labels | map(.name) | contains(["enhancement"])) then
      "ENHANCE|\(.title) (#\(.number))"
    else empty end
  ' | awk -F'|' '
    /^FEATURE/ { features = features "- " $2 "\n" }
    /^BUG/ { bugs = bugs "- " $2 "\n" }
    /^ENHANCE/ { enhancements = enhancements "- " $2 "\n" }
    END {
      if (features) printf "## 🎉 New Features\n\n%s\n", features
      if (bugs) printf "## 🐛 Bug Fixes\n\n%s\n", bugs
      if (enhancements) printf "## 🚀 Enhancements\n\n%s\n", enhancements
    }
  ' > /tmp/changelog.txt

CHANGELOG=$(cat /tmp/changelog.txt)

# Generate contributors list
gh pr list --state merged --base master --limit 1000 --json number,mergedAt,author | \
  jq --arg prev_date "$PREV_DATE" -r '
    [.[] | select(.mergedAt > $prev_date) | .author.login] |
    group_by(.) |
    map({user: .[0], count: length}) |
    sort_by(.count) |
    reverse |
    map(select(.user != "app/dependabot")) |
    .[] |
    "<a href=\"https://github.com/\(.user)\"><img src=\"https://github.com/\(.user).png?size=50\" width=\"50\" height=\"50\" style=\"border-radius: 50%;\" alt=\"@\(.user)\"/></a>"
  ' | tr '\n' ' ' > /tmp/contributors.txt

CONTRIBUTORS=$(cat /tmp/contributors.txt)

# Generate release notes
cat > release-notes.md << EOF

**Commit:** [\`${COMMIT_SHORT}\`](https://github.com/arturo-lang/arturo/commit/${COMMIT_SHA})

---

${CHANGELOG}

## 👥 Contributors

${CONTRIBUTORS}

**Full Changelog**: https://github.com/arturo-lang/arturo/compare/${PREV_TAG}...${CURR_TAG}
EOF

echo "Release notes generated successfully!"