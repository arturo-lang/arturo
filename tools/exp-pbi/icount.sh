#!/bin/bash
# EXPERIMENTAL: instructions per `+` (valgrind/callgrind: deterministic, unaffected by code layout & noise)
# usage: icount.sh <binary>...
cd "$(dirname "$0")"
N=200000
CASES="empty small int int-inplace overflow big1+small big2+big2 big+big2small big32+big32"
tmp=$(mktemp -d)
for c in $CASES; do sed "s/1\.\.3000000/1..$N/" "$c.art" > "$tmp/$c.art"; done
declare -A IR
for b in "$@"; do
    for c in $CASES; do
        IR[$b,$c]=$(valgrind --tool=callgrind --callgrind-out-file=/dev/null "$b" "$tmp/$c.art" 2>&1 | sed -n 's/.*Collected : \([0-9]*\).*/\1/p')
    done
done
printf "| case |"; for b in "$@"; do printf " %s instr/op |" "$(basename "$b")"; done; echo
printf "|---|"; for b in "$@"; do printf -- "---|"; done; echo
for c in $CASES; do
    [ "$c" = empty ] && continue
    printf "| %s |" "$c"
    for b in "$@"; do printf " %.0f |" "$(echo "(${IR[$b,$c]} - ${IR[$b,empty]}) / $N" | bc -l)"; done
    echo
done
printf "| (loop overhead) |"; for b in "$@"; do printf " %.0f |" "$(echo "${IR[$b,empty]} / $N" | bc -l)"; done; echo
rm -rf "$tmp"
