#!/bin/bash
# count_files_dirs_links.sh
# Counts regular files, directories, and symbolic links inside a given directory.
# Counts recursively (including the given directory itself for the directory count).
# Usage:
#   ./count_files_dirs_links.sh <directory>
#   ./count_files_dirs_links.sh            (will prompt for input)

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

# -type f : regular files
# -type d : directories
# -type l : symbolic links
# We do NOT follow symlinks (find without -L) so links are counted as links,
# not as their targets.
files=$(find "$DIR_PATH" -type f 2>/dev/null | wc -l | tr -d ' ')
dirs=$(find "$DIR_PATH" -type d 2>/dev/null | wc -l | tr -d ' ')
links=$(find "$DIR_PATH" -type l 2>/dev/null | wc -l | tr -d ' ')

echo "Summary for '$DIR_PATH':"
echo "----------------------------------"
printf "  Regular files:   %d\n" "$files"
printf "  Directories:     %d\n" "$dirs"
printf "  Symbolic links:  %d\n" "$links"
echo "----------------------------------"
