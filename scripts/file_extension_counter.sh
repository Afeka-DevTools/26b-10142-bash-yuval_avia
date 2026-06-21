#!/bin/bash
# file_extension_counter.sh
# Counts files in a directory grouped by their extension.
# Files without an extension are reported under "(no extension)".
# Usage:
#   ./file_extension_counter.sh <directory>
#   ./file_extension_counter.sh           (will prompt for input)

set -u

DIR_PATH="${1:-}"

if [[ -z "$DIR_PATH" ]]; then
    read -r -p "Enter the directory path: " DIR_PATH
fi

# Validate the directory
if [[ ! -d "$DIR_PATH" ]]; then
    echo "Error: '$DIR_PATH' is not a valid directory." >&2
    exit 1
fi

echo "Counting files by extension in '$DIR_PATH'..."
echo "---------------------------------------------"

total=0
# Temporary file to collect extensions, one per line.
# Using a temp file keeps the script portable across bash versions (no associative arrays).
TMP_FILE="$(mktemp)"
trap 'rm -f "$TMP_FILE"' EXIT

# Iterate over regular files recursively, NUL-separated to handle spaces
while IFS= read -r -d '' file; do
    name="$(basename "$file")"

    # Determine the extension safely:
    # - If filename contains a dot AND does not start with a dot (hidden file with no ext),
    #   take the part after the LAST dot as the extension.
    # - Otherwise, treat as no extension.
    if [[ "$name" == *.* && "$name" != .* ]]; then
        ext="${name##*.}"
        if [[ -z "$ext" ]]; then
            ext="(no extension)"
        fi
    else
        ext="(no extension)"
    fi

    echo "$ext" >> "$TMP_FILE"
    total=$((total + 1))
done < <(find "$DIR_PATH" -type f -print0)

if [[ "$total" -eq 0 ]]; then
    echo "No files were found in '$DIR_PATH'."
    exit 0
fi

# Sort, count, and pretty-print descending by count.
sort "$TMP_FILE" \
    | uniq -c \
    | sort -rn \
    | awk '{ count=$1; $1=""; sub(/^ /,""); printf "  %-20s %d\n", $0, count }'

echo "---------------------------------------------"
echo "Total files: $total"
