# 26b-10142-bash-yuval_avia

A Bash scripting homework project.
This repository contains a collection of useful scripts written in Bash.

## Team Members

- Full Name: avia lurie (ID: 315150516)
- Full Name: Yuval Arvili (ID: 214630089)

## Scripts

All scripts live in the `scripts/` directory:

| # | File | Description |
|---|------|-------------|
| 1 | `scripts/backup_directory.sh` | Creates a compressed `tar.gz` backup of a given directory. |
| 2 | `scripts/internet_check.sh` | Checks internet connectivity against `8.8.8.8` and `google.com` with a timestamped log. |
| 3 | `scripts/delete_old_files.sh` | Finds and deletes files older than X days in a given directory, after user confirmation. |
| 4 | `scripts/word_frequency.sh` | Counts word frequency in a text file and prints it sorted in descending order. |
| 5 | `scripts/file_extension_counter.sh` | Counts files in a directory grouped by extension and prints a clean summary. |
| 6 | `scripts/random_password.sh` | Generates a random 10-character password (uppercase, lowercase, digits, special chars). |
| 7 | `scripts/count_files_dirs_links.sh` | Counts regular files, directories, and symbolic links inside a given directory. |
| 8 | `scripts/current_user_info.sh` | Displays information about the current user (username, home dir, groups, shell). |
| 9 | `scripts/sort_file_lines.sh` | Sorts the lines of a text file alphabetically and outputs to screen or new file. |
| 10 | `scripts/large_files_check.sh` | Finds files larger than a given size threshold inside a directory. |

## Clone the Repository

HTTPS:

```bash
git clone https://github.com/Afeka-DevTools/26b-10142-bash-yuval_avia.git
cd 26b-10142-bash-yuval_avia
```

SSH:

```bash
git clone git@github.com:Afeka-DevTools/26b-10142-bash-yuval_avia.git
cd 26b-10142-bash-yuval_avia
```

## Make Scripts Executable

Before running the scripts for the first time, give them execute permissions:

```bash
chmod +x scripts/*.sh
```

## Running the Scripts – Usage and Examples

> Every script can be run either with command-line arguments, or with no arguments – in which case it will prompt the user for input interactively.

### 1. Backup a Directory – `backup_directory.sh`

Creates a `tar.gz` archive of the given directory.

```bash
# With arguments
./scripts/backup_directory.sh /path/to/source backup.tar.gz

# Without arguments (interactive prompt)
./scripts/backup_directory.sh
```

Example:

```bash
./scripts/backup_directory.sh ~/Documents documents_backup.tar.gz
```

### 2. Internet Connectivity Check – `internet_check.sh`

Pings `8.8.8.8` and `google.com` and prints a timestamped log.

```bash
./scripts/internet_check.sh
```

### 3. Delete Old Files – `delete_old_files.sh`

Finds files older than X days, shows them, and asks for confirmation before deletion.

```bash
# With arguments: directory and number of days
./scripts/delete_old_files.sh /path/to/dir 30

# Without arguments (interactive prompt)
./scripts/delete_old_files.sh
```

Example – delete files older than 7 days in `/tmp`:

```bash
./scripts/delete_old_files.sh /tmp 7
```

### 4. Word Frequency – `word_frequency.sh`

Counts how many times each word appears in a text file, sorted in descending order.

```bash
# With argument
./scripts/word_frequency.sh /path/to/file.txt

# Without argument (interactive prompt)
./scripts/word_frequency.sh
```

Example:

```bash
./scripts/word_frequency.sh README.md
```

### 5. File Extension Counter – `file_extension_counter.sh`

Recursively walks a directory and counts files by extension (including files without an extension).

```bash
# With argument
./scripts/file_extension_counter.sh /path/to/dir

# Without argument (interactive prompt)
./scripts/file_extension_counter.sh
```

Example:

```bash
./scripts/file_extension_counter.sh ~/Downloads
```

### 6. Random Password – `random_password.sh`

Generates a random 10-character password containing at least one uppercase letter, one lowercase letter, one digit, and one special character.

```bash
./scripts/random_password.sh
```

### 7. Count Files, Directories, and Symbolic Links – `count_files_dirs_links.sh`

Recursively counts regular files, directories, and symbolic links inside a directory.

```bash
# With argument
./scripts/count_files_dirs_links.sh /path/to/dir

# Without argument (interactive prompt)
./scripts/count_files_dirs_links.sh
```

Example:

```bash
./scripts/count_files_dirs_links.sh ~/Projects
```

### 8. Current User Info – `current_user_info.sh`

Displays the current user's username, home directory, groups, and configured login shell.

```bash
./scripts/current_user_info.sh
```

### 9. Sort File Lines – `sort_file_lines.sh`

Sorts the lines of a file alphabetically. Asks whether to print the result to screen or save it to a new file.

```bash
# With argument
./scripts/sort_file_lines.sh /path/to/file.txt

# Without argument (interactive prompt)
./scripts/sort_file_lines.sh
```

Example:

```bash
./scripts/sort_file_lines.sh names.txt
```

### 10. Large Files Check – `large_files_check.sh`

Finds files larger than a given size threshold inside a directory.
Threshold format examples: `500K`, `10M`, `1G`.

```bash
# With arguments: directory and size threshold
./scripts/large_files_check.sh /path/to/dir 10M

# Without arguments (interactive prompt)
./scripts/large_files_check.sh
```

Example – find files larger than 100 MB in your home directory:

```bash
./scripts/large_files_check.sh ~ 100M
```

## Notes

- All scripts start with `#!/bin/bash` and follow safe Bash practices (`set -u`, quoted variables, etc.).
- Every script validates its input (directory/file existence, valid numeric values, etc.).
- If something does not work, make sure the scripts have execute permissions:

```bash
chmod +x scripts/*.sh
```
