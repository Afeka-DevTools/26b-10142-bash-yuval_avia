#!/bin/bash
# delete_old_files.sh
# Finds and deletes files older than X days in a given directory,
# after showing the list and asking for user confirmation.
# Usage:
#   ./delete_old_files.sh <directory> <days>
#   ./delete_old_files.sh           (will prompt for input)

set -u

DIR_PATH="${1:-}"
DAYS="${2:-}"

if [[ -z "$DIR_PATH" ]]; then
    read -r -p "Enter the directory path: " DIR_PATH
fi

if [[ -z "$DAYS" ]]; then
    read -r -p "Enter the number of days (X): " DAYS
fi

# Validate the directory
if [[ ! -d "$DIR_PATH" ]]; then
    echo "Error: '$DIR_PATH' is not a valid directory." >&2
    exit 1
fi

# Validate that DAYS is a positive integer
if ! [[ "$DAYS" =~ ^[0-9]+$ ]]; then
    echo "Error: Days must be a non-negative integer (got: '$DAYS')." >&2
    exit 1
fi

echo "Searching for files older than $DAYS days in '$DIR_PATH'..."

# Build a list of files older than X days (regular files only)
OLD_FILES=()
while IFS= read -r -d '' file; do
    OLD_FILES+=("$file")
done < <(find "$DIR_PATH" -type f -mtime +"$DAYS" -print0)

if [[ "${#OLD_FILES[@]}" -eq 0 ]]; then
    echo "No files older than $DAYS days were found. Nothing to do."
    exit 0
fi

echo "The following ${#OLD_FILES[@]} file(s) will be deleted:"
for f in "${OLD_FILES[@]}"; do
    echo "  - $f"
done

read -r -p "Are you sure you want to delete these files? (y/N): " CONFIRM
case "$CONFIRM" in
    y|Y|yes|YES)
        ;;
    *)
        echo "Aborted by user. No files were deleted."
        exit 0
        ;;
esac

deleted=0
failed=0
for f in "${OLD_FILES[@]}"; do
    if rm -f -- "$f"; then
        deleted=$((deleted + 1))
    else
        echo "Error: Failed to delete '$f'." >&2
        failed=$((failed + 1))
    fi
done

echo "Done. Deleted: $deleted, Failed: $failed."
[[ "$failed" -eq 0 ]] && exit 0 || exit 2
