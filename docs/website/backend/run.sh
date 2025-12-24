#!/bin/sh
# =============================================================================
# ARTURO JAIL EXECUTION SCRIPT
# =============================================================================
# Usage: run.sh <columns> <script_path> [arg1] [arg2] ...
#
# This script executes Arturo code
# with proper environment setup and timeout

if [ $# -lt 2 ]; then
    echo "Usage: $0 <columns> <script_path> [args...]" >&2
    exit 1
fi

# Set environment
HOME=/root
LD_LIBRARY_PATH=/usr/local/lib
COLUMNS="$1"
LINES=24
export HOME LD_LIBRARY_PATH COLUMNS LINES

# Shift off the columns parameter
shift

# Now $@ contains script_path and any additional arguments
timeout --kill-after=3s 10s /usr/local/bin/arturo "$@" 2>&1