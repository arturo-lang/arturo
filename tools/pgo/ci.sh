#!/usr/bin/env bash
# temporary: build, train, compare & test on the CI, for measuring PGO
#
# env:
#   CCKIND  gcc | clang
#   MODE    full | mini
#   EXTRA   extra flags for all release builds (e.g. -flto), optional
#   ARCHFLAG e.g. "--arch amd64", optional

set -eu

MODE="${MODE:-full}"
EXTRA="${EXTRA:-}"
ARCHFLAG="${ARCHFLAG:-}"
SUMMARY="${GITHUB_STEP_SUMMARY:-/dev/null}"

ext=""
case "$(uname -s)" in
    MINGW*|MSYS*|CYGWIN*) ext=".exe" ;;
esac

build() {
    name="$1"
    flags="$2"
    echo "::group::build $name ($flags)"
    start=$(date +%s)
    if ! PGO_FLAGS="$flags" ./build.nims --release --as "$name" --mode "$MODE" --log $ARCHFLAG > "$name.log" 2>&1; then
        tail -40 "$name.log"
        echo "::endgroup::"
        exit 1
    fi
    echo "took $(( $(date +%s) - start ))s, fprofile mentions: $(grep -c fprofile "$name.log" || true)"
    ls -la "bin/$name$ext"
    echo "::endgroup::"
}

profdata() {
    if command -v xcrun > /dev/null 2>&1; then
        echo "xcrun llvm-profdata"
        return
    fi
    for p in llvm-profdata /usr/bin/llvm-profdata /usr/local/bin/llvm-profdata*; do
        if command -v "$p" > /dev/null 2>&1; then
            echo "$p"
            return
        fi
    done
    return 1
}

# baseline builds

bins=""
if [ -n "$EXTRA" ]; then
    build plain ""
    bins="bin/plain$ext"
fi
build base "$EXTRA"
bins="$bins bin/base$ext"

# instrumented build + training

if [ "$CCKIND" = "clang" ]; then
    build instr "-fprofile-instr-generate $EXTRA"
else
    build instr "-fprofile-generate -fprofile-update=single $EXTRA"
fi

echo "::group::train"
rm -rf prof
mkdir -p prof
export LLVM_PROFILE_FILE="$PWD/prof/%p.profraw"
start=$(date +%s)
perl tools/pgo/run.pl train "bin/instr$ext"
echo "training took $(( $(date +%s) - start ))s"
if [ "$CCKIND" = "clang" ]; then
    if ! pd=$(profdata); then
        pkg install -y llvm > /dev/null
        pd=$(profdata)
    fi
    echo "profraw files: $(ls prof | wc -l), using: $pd"
    $pd merge -o arturo.profdata prof/*.profraw
    ls -la arturo.profdata
    pgoflags="-fprofile-instr-use=$PWD/arturo.profdata $EXTRA"
else
    gcda=$(find .cache -name '*.gcda' | wc -l)
    echo "gcda files: $gcda"
    [ "$gcda" -gt 0 ]
    pgoflags="-fprofile-use -fprofile-correction -Wno-missing-profile $EXTRA"
fi
echo "::endgroup::"

# optimized build

build pgo "$pgoflags"
bins="$bins bin/pgo$ext"

# comparison

{
    echo "## $(uname -s) $(uname -m) ($CCKIND, $MODE) $EXTRA"
    for b in $bins; do echo "- $b: $(wc -c < "$b" | tr -d ' ') bytes"; done
    echo
} | tee -a "$SUMMARY"
perl tools/pgo/run.pl bench 5 $bins

# test suite, with every binary

[ -d ../examples ] || git clone --depth 1 https://github.com/arturo-lang/examples.git ../examples

failed=0
for b in $bins; do
    echo "::group::tests with $b"
    rc=0
    "./$b" tools/tester.art > suite.log 2>&1 || rc=$?
    sed -E 's/\x1b\[[0-9;]*m//g' suite.log > suite.txt
    echo "tester rc: $rc"
    if [ "$rc" != "0" ] || ! grep -q "Success rate: 100" suite.txt; then
        tail -40 suite.txt
        failed=1
    fi
    echo "::endgroup::"
    {
        echo
        echo "**tests with $b** (rc: $rc)"
        echo
        grep -E "Tests executed|Tests succeeded|Success rate" suite.txt | sed 's/^/    /' || true
    } | tee -a "$SUMMARY"
done

exit $failed
