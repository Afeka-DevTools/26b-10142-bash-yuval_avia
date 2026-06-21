#!/bin/bash
# random_password.sh
# Generates a random 10-character password that contains at least:
#   - one uppercase letter
#   - one lowercase letter
#   - one digit
#   - one special character
# Usage:
#   ./random_password.sh

set -u

LENGTH=10
UPPER='ABCDEFGHIJKLMNOPQRSTUVWXYZ'
LOWER='abcdefghijklmnopqrstuvwxyz'
DIGITS='0123456789'
SPECIAL='!@#$%^&*()-_=+[]{};:,.?/'
ALL="${UPPER}${LOWER}${DIGITS}${SPECIAL}"

# Pick a single random character from a given string.
# Uses $RANDOM (built-in Bash random number generator).
pick_char() {
    local set="$1"
    local idx=$(( RANDOM % ${#set} ))
    printf '%s' "${set:$idx:1}"
}

# Shuffle a string by splitting it to one char per line,
# piping through `sort -R` (random) and joining back.
shuffle_string() {
    local s="$1"
    printf '%s' "$s" | fold -w1 | sort -R | tr -d '\n'
}

# Guarantee at least one char from each required category.
password=""
password+="$(pick_char "$UPPER")"
password+="$(pick_char "$LOWER")"
password+="$(pick_char "$DIGITS")"
password+="$(pick_char "$SPECIAL")"

# Fill the rest with characters from the combined set.
remaining=$(( LENGTH - 4 ))
for ((i = 0; i < remaining; i++)); do
    password+="$(pick_char "$ALL")"
done

# Shuffle so the required chars are not always in the first 4 positions.
password="$(shuffle_string "$password")"

# Final sanity check (defensive — should always pass).
if [[ ${#password} -ne $LENGTH ]] \
    || ! [[ "$password" =~ [A-Z] ]] \
    || ! [[ "$password" =~ [a-z] ]] \
    || ! [[ "$password" =~ [0-9] ]] \
    || ! [[ "$password" =~ [^A-Za-z0-9] ]]; then
    echo "Error: failed to generate a valid password. Please try again." >&2
    exit 1
fi

echo "Generated password: $password"
