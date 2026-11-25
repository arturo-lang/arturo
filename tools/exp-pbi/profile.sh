#!/bin/bash
# EXPERIMENTAL: where the instructions go (callgrind, self cost per function) - small & int cases
cd "$(dirname "$0")"
tmp=$(mktemp -d)
for c in small int; do sed "s/1\.\.3000000/1..200000/" "$c.art" > "$tmp/$c.art"; done
for c in small int; do
    for b in "$@"; do
        echo "=== $c / $(basename "$b")"
        valgrind --tool=callgrind --callgrind-out-file="$tmp/cg" "$b" "$tmp/$c.art" > /dev/null 2>&1
        callgrind_annotate --inclusive=no "$tmp/cg" 2>/dev/null | grep -E '^ *[0-9,]+ ' | head -14
    done
done
rm -rf "$tmp"
