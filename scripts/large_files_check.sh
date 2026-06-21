#!/bin/bash
# large_files_check.sh
# Finds files larger than a given size threshold inside a directory.
# Threshold format examples: 500K, 10M, 1G  (also accepted: 1024 = bytes, or 1024c).
# Usage:
#   ./large_files_check.sh <directory> <size>
#   ./large_files_check.sh           (will prompt for input)

set -u

DIR_PATH="${1:-}"
SIZE="${2:-}"

if [[ -z "$DIR_PATH" ]]; then
    read -r -p "Enter the directory path: " DIR_PATH
fi

if [[ -z "$SIZE" ]]; then
    read -r -p "Enter the size threshold (e.g. 500K, 10M, 1G): " SIZE
fi

# Validate the directory
if [[ ! -d "$DIR_PATH" ]]; then
    echo "Error: '$DIR_PATH' is not a valid directory." >&2
    exit 1
fi

# Validate the size:
# - A positive integer optionally followed by a unit suffix: c (bytes), k/K, M, G, T.
# - Bare numbers are treated as kilobytes by `find -size`, which can confuse users,
#   so we require an explicit unit.
if ! [[ "$SIZE" =~ ^[0-9]+[cKkMGT]$ ]]; then
    echo "Error: Invalid size '$SIZE'. Use formats like 500K, 10M, 1G." >&2
    exit 1
fi

# Convert lowercase 'k' to 'K' for portability between BSD and GNU find.
SIZE_NORMALIZED="${SIZE/k/K}"

echo "Searching for files larger than $SIZE_NORMALIZED in '$DIR_PATH'..."
echo "------------------------------------------------------------"

# `find -size +N` matches files strictly larger than N.
# `-printf` is GNU-only; use `-exec ls -lh` for portability (works on macOS too).
count=0
while IFS= read -r -d '' file; do
    size_human=$(du -h "$file" 2>/dev/null | cut -f1)
    printf "  [%s]\t%s\n" "$size_human" "$file"
    count=$((count + 1))
done < <(find "$DIR_PATH" -type f -size +"$SIZE_NORMALIZED" -print0 2>/dev/null)

echo "------------------------------------------------------------"
if [[ "$count" -eq 0 ]]; then
    echo "No files larger than $SIZE_NORMALIZED were found."
else
    echo "Total: $count file(s) larger than $SIZE_NORMALIZED."
fi
