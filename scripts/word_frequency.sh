#!/bin/bash
# word_frequency.sh
# Counts word frequency in a given text file and prints words
# sorted by frequency (descending).
# Usage:
#   ./word_frequency.sh <file_path>
#   ./word_frequency.sh           (will prompt for input)

set -u

FILE_PATH="${1:-}"

if [[ -z "$FILE_PATH" ]]; then
    read -r -p "Enter the file path: " FILE_PATH
fi

# Validate file existence and that it is a regular readable file
if [[ ! -f "$FILE_PATH" ]]; then
    echo "Error: File '$FILE_PATH' does not exist." >&2
    exit 1
fi

if [[ ! -r "$FILE_PATH" ]]; then
    echo "Error: File '$FILE_PATH' is not readable." >&2
    exit 1
fi

echo "Word frequency in '$FILE_PATH' (descending):"
echo "-------------------------------------------"

# Pipeline:
# 1. tr -c '[:alnum:]_' '\n' : replace any non-alphanumeric char with newline
#    so each word ends up on its own line.
# 2. tr to lowercase to treat "Hello" and "hello" as the same word.
# 3. grep -v '^$' : drop empty lines.
# 4. sort | uniq -c : count occurrences.
# 5. sort -rn : sort numerically, descending by count.
tr -c '[:alnum:]_' '\n' < "$FILE_PATH" \
    | tr '[:upper:]' '[:lower:]' \
    | grep -v '^$' \
    | sort \
    | uniq -c \
    | sort -rn
