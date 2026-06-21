#!/bin/bash
# current_user_info.sh
# Displays information about the current user:
#   - username
#   - home directory
#   - groups
#   - configured shell
# Usage:
#   ./current_user_info.sh

set -u

# Username: prefer $USER, fall back to `id -un`.
username="${USER:-$(id -un)}"

# Home directory: prefer $HOME, fall back to passwd entry.
home_dir="${HOME:-$(getent passwd "$username" 2>/dev/null | cut -d: -f6)}"
if [[ -z "$home_dir" ]]; then
    # getent is not always available on macOS; fall back to ~ expansion.
    home_dir=$(eval echo "~$username")
fi

# Groups the user belongs to.
groups_list=$(id -Gn "$username" 2>/dev/null || echo "(unknown)")

# Configured login shell:
# Try `getent passwd` first (Linux), then `dscl` (macOS), then $SHELL.
shell_path=""
if command -v getent >/dev/null 2>&1; then
    shell_path=$(getent passwd "$username" 2>/dev/null | cut -d: -f7)
fi
if [[ -z "$shell_path" ]] && command -v dscl >/dev/null 2>&1; then
    shell_path=$(dscl . -read "/Users/$username" UserShell 2>/dev/null | awk '{print $2}')
fi
if [[ -z "$shell_path" ]]; then
    shell_path="${SHELL:-(unknown)}"
fi

echo "Current user information"
echo "========================"
printf "  Username:      %s\n" "$username"
printf "  Home dir:      %s\n" "$home_dir"
printf "  Groups:        %s\n" "$groups_list"
printf "  Login shell:   %s\n" "$shell_path"
