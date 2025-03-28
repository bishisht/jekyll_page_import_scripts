# jekyll_page_import_scripts

## Overview
This repository contains scripts to assist in backing up Jekyll-related files, identifying file types in a backup, moving files into the Jekyll directory structure, reversing file moves, and tidying up HTML files. These scripts help maintain an organized workflow when migrating or managing content in Jekyll projects.

## Prerequisites
- Ruby must be installed on your system.
- Ensure you have the necessary permissions to read from source directories and write to backup locations.
- The `tidy` command-line tool must be installed for the HTML tidy script.

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

## 3. File Movement Script

### Description
The `3.1_move_files.rb` script moves files from the latest backup folder into the appropriate locations within a Jekyll project directory based on file extensions.

### Usage
1. Open a terminal.
2. Navigate to the directory containing the script:
   ```sh
   cd /Users/bishisht/work/personal_projects/jekyll_page_import_scripts
   ```
3. Run the script with the following command:
   ```sh
   ruby 3.1_move_files.rb <jekyll_root_directory>
   ```
   - Replace `<jekyll_root_directory>` with the root directory of your Jekyll project.

### Output
- Files from the latest backup are moved to appropriate Jekyll folders.
- A log file `3.1.file_movement_log.txt` is created, recording the moved files.

---

## 4. Reverse File Movement Script (Not Tested)

### Description
The `3.2_reverse_file_movement.rb` script is designed to undo file moves performed by `3.1_move_files.rb`. However, this script has **not been tested yet**, so use it with caution.

### Usage
1. Open a terminal.
2. Navigate to the directory containing the script:
   ```sh
   cd /Users/bishisht/work/personal_projects/jekyll_page_import_scripts
   ```
3. Run the script with the following command:
   ```sh
   ruby 3.2_reverse_file_movement.rb <jekyll_root_directory>
   ```
   - Replace `<jekyll_root_directory>` with the root directory of your Jekyll project.

### Warning
- This script is **not tested** and may not work as expected.
- Verify file movements manually before relying on this script.

---

## 5. HTML Tidy-Up Script

### Description
The `4.0_tidy_html.rb` script tidies up all HTML files inside the `_pages` directory of a Jekyll project. It uses the `tidy` command-line tool to format and clean the files.

### Prerequisites
- Ensure that `tidy` is installed on your system. You can install it using:
  ```sh
  brew install tidy-html5  # macOS (Homebrew)
  sudo apt install tidy     # Ubuntu/Debian
  ```

### Usage
1. Open a terminal.
2. Navigate to the directory containing the script:
   ```sh
   cd /Users/bishisht/work/personal_projects/jekyll_page_import_scripts
   ```
3. Run the script with the following command:
   ```sh
   ruby 4.0_tidy_html.rb <_pages_directory>
   ```
   - Replace `<_pages_directory>` with the path to the `_pages` folder in your Jekyll project.

### Output
- All `.html` files inside the `_pages` directory are formatted and cleaned.
- A log file `4.0.tidy_log.txt` is created, listing all processed files.

---

## Notes
- Ensure that you run `1.backup_script.rb` before `2.identify_file_types.rb`, as the latter depends on the backup log.
- Run `3.1_move_files.rb` only if the backup is correctly identified and categorized.
- The `3.2_reverse_file_movement.rb` script is untested—use with caution.
- The `4.0_tidy_html.rb` script requires the `tidy` tool to be installed.

## License
This project is licensed under the MIT License.

## Author
Bishisht

