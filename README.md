# 26b-10142-bash-yuval_avia

A Bash scripting homework project.
This repository contains a collection of useful scripts written in Bash.

## Team Members

- Full Name: avia lurie (ID: 315150516)
- Full Name: _____________ (ID / Student #: _______)

## Scripts

All scripts live in the `scripts/` directory:

| # | File | Description |
|---|------|-------------|
| 1 | `scripts/backup_directory.sh` | Creates a compressed `tar.gz` backup of a given directory. |
| 2 | `scripts/internet_check.sh` | Checks internet connectivity against `8.8.8.8` and `google.com` with a timestamped log. |
| 3 | `scripts/delete_old_files.sh` | Finds and deletes files older than X days in a given directory, after user confirmation. |
| 4 | `scripts/word_frequency.sh` | Counts word frequency in a text file and prints it sorted in descending order. |
| 5 | `scripts/file_extension_counter.sh` | Counts files in a directory grouped by extension and prints a clean summary. |

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

## Notes

- All scripts start with `#!/bin/bash` and follow safe Bash practices (`set -u`, quoted variables, etc.).
- Every script validates its input (directory/file existence, valid numeric values, etc.).
- If something does not work, make sure the scripts have execute permissions:

```bash
chmod +x scripts/*.sh
```
