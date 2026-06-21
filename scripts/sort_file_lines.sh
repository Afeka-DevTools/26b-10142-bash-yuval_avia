#!/bin/bash
# sort_file_lines.sh
# Sorts the lines of a given text file alphabetically.
# Asks the user whether to print the result to screen or save it to a new file.
# Usage:
#   ./sort_file_lines.sh <file_path>
#   ./sort_file_lines.sh           (will prompt for input)

set -u

FILE_PATH="${1:-}"

if [[ -z "$FILE_PATH" ]]; then
    read -r -p "Enter the file path: " FILE_PATH
fi

# Validate the file
if [[ ! -f "$FILE_PATH" ]]; then
    echo "Error: File '$FILE_PATH' does not exist." >&2
    exit 1
fi

if [[ ! -r "$FILE_PATH" ]]; then
    echo "Error: File '$FILE_PATH' is not readable." >&2
    exit 1
fi

echo "What would you like to do with the sorted output?"
echo "  1) Print to screen"
echo "  2) Save to a new file"
read -r -p "Choose 1 or 2: " CHOICE

case "$CHOICE" in
    1)
        echo "Sorted contents of '$FILE_PATH':"
        echo "--------------------------------"
        sort "$FILE_PATH"
        ;;
    2)
        read -r -p "Enter the output file path: " OUT_FILE
        if [[ -z "$OUT_FILE" ]]; then
            echo "Error: Output file path cannot be empty." >&2
            exit 1
        fi
        # Refuse to overwrite the source file by accident.
        if [[ "$OUT_FILE" == "$FILE_PATH" ]]; then
            echo "Error: Output file must be different from the source file." >&2
            exit 1
        fi
        if sort "$FILE_PATH" > "$OUT_FILE"; then
            echo "Success: Sorted output saved to '$OUT_FILE'."
        else
            echo "Error: Failed to write to '$OUT_FILE'." >&2
            exit 2
        fi
        ;;
    *)
        echo "Error: Invalid choice '$CHOICE'. Please choose 1 or 2." >&2
        exit 1
        ;;
esac
