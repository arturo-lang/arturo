#!/usr/bin/env bash

# Let's say we have generated 2 different test binaries, using:
#    ./build.nims --as:arturo-X
#
# These version will be in the /bin folder.
#
# If we want to test the two versions, in terms of performance,
# against a specific script, we can simply do:
#    ./tools/hf.sh path/to/our/script.art vers1 vers2
#
# (where vers1 & vers2 are the different suffixes - see: "-X"
#  we used above when compiling the binaries ;-))

script=$1
vers1=$2
vers2=$3

hyperfine "bin/arturo-${vers1} ${script}" "bin/arturo-${vers2} ${script}"