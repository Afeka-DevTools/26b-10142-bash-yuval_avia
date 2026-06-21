#!/bin/bash
# internet_check.sh
# Checks internet connectivity by pinging 8.8.8.8 and google.com.
# Prints a timestamped log of the result to the screen.
# Usage:
#   ./internet_check.sh

set -u

TARGETS=("8.8.8.8" "google.com")
PING_COUNT=2

timestamp() {
    date +"%Y-%m-%d %H:%M:%S"
}

overall_status=0

echo "[$(timestamp)] Starting internet connectivity check..."

for target in "${TARGETS[@]}"; do
    # -c: number of pings, -W: timeout in seconds per reply (works on macOS & Linux)
    if ping -c "$PING_COUNT" -W 2 "$target" >/dev/null 2>&1; then
        echo "[$(timestamp)] SUCCESS: Connection to $target is OK."
    else
        echo "[$(timestamp)] FAILURE: Could not reach $target."
        overall_status=1
    fi
done

if [[ "$overall_status" -eq 0 ]]; then
    echo "[$(timestamp)] Internet connection looks good."
    exit 0
else
    echo "[$(timestamp)] Internet connection problem detected."
    exit 1
fi
