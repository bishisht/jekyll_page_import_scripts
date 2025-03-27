# jekyll_page_import_scripts

## Overview
This repository contains scripts to assist in backing up Jekyll-related files and identifying file types in a backup. These scripts help maintain an organized workflow when migrating or managing content in Jekyll projects.

## Prerequisites
- Ruby must be installed on your system.
- Ensure you have the necessary permissions to read from source directories and write to backup locations.

---

## 1. Backup Script

### Description
The `1.backup_script.rb` script is responsible for creating a backup of a specified source directory to a designated backup directory. It also logs backup actions and generates an information file containing details of the backed-up files.

### Usage
1. Open a terminal.
2. Navigate to the directory containing the script:
   ```sh
   cd /Users/bishisht/work/personal_projects/jekyll_page_import_scripts
   ```
3. Run the script with the following command:
   ```sh
   ruby 1.backup_script.rb <source_directory> <backup_directory>
   ```
   - Replace `<source_directory>` with the path of the folder you want to back up.
   - Replace `<backup_directory>` with the folder where the backup should be stored.

### Output
- A new backup folder is created inside `<backup_directory>` with a timestamp.
- A log file `1.backup_script_actions_logs.txt` is generated, recording the backup details.
- A file `1.backed_up_file_info.txt` is created, listing all backed-up files.

---

## 2. File Type Identifier Script

### Description
The `2.identify_file_types.rb` script scans the most recent backup directory and categorizes files based on their extensions. It helps in understanding the composition of the backup.

### Usage
1. Open a terminal.
2. Navigate to the directory containing the script:
   ```sh
   cd /Users/bishisht/work/personal_projects/jekyll_page_import_scripts
   ```
3. Run the script:
   ```sh
   ruby 2.identify_file_types.rb
   ```
   - The script automatically finds the most recent backup folder using `1.backup_script_actions_logs.txt`.

### Output
- A file `2.identified_files.txt` is created, listing file types and their counts.
- The categorized summary is displayed in the terminal.

---

## Notes
- Ensure that you run `1.backup_script.rb` before `2.identify_file_types.rb`, as the latter depends on the backup log.
- The scripts are intended for use with Jekyll-related files but can be adapted for general backup and file identification purposes.

## License
This project is licensed under the MIT License.

## Author
Bishisht

