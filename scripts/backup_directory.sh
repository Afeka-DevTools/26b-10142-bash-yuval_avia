#!/bin/bash
# backup_directory.sh
# Creates a compressed tar.gz backup of a given source directory.
# Usage:
#   ./backup_directory.sh <source_directory> <output_file.tar.gz>
#   ./backup_directory.sh           (will prompt for input)

set -u

SRC_DIR="${1:-}"
OUT_FILE="${2:-}"

# Prompt the user if arguments are missing
if [[ -z "$SRC_DIR" ]]; then
    read -r -p "Enter the source directory path: " SRC_DIR
fi

if [[ -z "$OUT_FILE" ]]; then
    read -r -p "Enter the output filename (e.g. backup.tar.gz): " OUT_FILE
fi

# Validate source directory exists
if [[ ! -d "$SRC_DIR" ]]; then
    echo "Error: Source directory '$SRC_DIR' does not exist or is not a directory." >&2
    exit 1
fi

# Validate output filename is not empty
if [[ -z "$OUT_FILE" ]]; then
    echo "Error: Output filename cannot be empty." >&2
    exit 1
fi

# Make sure the output file ends with .tar.gz (just a friendly check)
if [[ "$OUT_FILE" != *.tar.gz ]]; then
    echo "Warning: Output filename does not end with .tar.gz, appending it."
    OUT_FILE="${OUT_FILE}.tar.gz"
fi

echo "Creating backup of '$SRC_DIR' into '$OUT_FILE'..."

# -c: create, -z: gzip, -f: file
if tar -czf "$OUT_FILE" -C "$(dirname "$SRC_DIR")" "$(basename "$SRC_DIR")"; then
    echo "Success: Backup created at '$OUT_FILE'."
    exit 0
else
    echo "Error: Failed to create backup." >&2
    exit 2
fi
