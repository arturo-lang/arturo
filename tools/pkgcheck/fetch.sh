#!/usr/bin/env bash
# temporary: fetch the sources of every package published on pkgr.art,
# at their published version, and install them into $HOME
#
# usage: fetch.sh TARGET_DIR

set -eu

target="$1"
mkdir -p "$target"

for pkg in $(curl -fsSL https://pkgr.art/list.art | grep -E '^[a-z0-9_-]+: #\[' | cut -d: -f1); do
    spec=$(curl -fsSL "https://$pkg.pkgr.art/spec")
    url=$(echo "$spec" | grep -m1 '^url:' | sed -E 's/^url: *"(.*)"/\1/')

    case "$url" in
        https://api.github.com/repos/*/zipball/*)
            repo=$(echo "$url" | sed -E 's|https://api.github.com/repos/([^/]+/[^/]+)/zipball/.*|\1|')
            tag=${url##*/}
            git clone -q --depth 1 --branch "$tag" "https://github.com/$repo.git" "$target/$pkg"
            ;;
        https://codeberg.org/*/archive/*.zip)
            repo=$(echo "$url" | sed -E 's|https://codeberg.org/([^/]+/[^/]+)/archive/.*|\1|')
            tag=$(basename "$url" .zip)
            git clone -q --depth 1 --branch "$tag" "https://codeberg.org/$repo.git" "$target/$pkg"
            ;;
        *)
            echo "unknown source for $pkg: $url"
            exit 1
            ;;
    esac

    arturo -p install "$pkg" > /dev/null < /dev/null
    echo "$pkg: $url"
done
