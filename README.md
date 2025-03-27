# jekyll_page_import_scripts

## Backup Script Instructions

The `1.backup_script.rb` script is used to create a backup of a specified source directory to a specified backup directory. It also generates a log file and an information file about the backup.

### Prerequisites

- Ruby must be installed on your system.
- Ensure you have the necessary permissions to read from the source directory and write to the backup directory.

### Usage

1. Open a terminal.
2. Navigate to the directory containing the script:
   ```bash
   cd /Users/bishisht/work/personal_projects/jekyll_page_import_scripts
   ruby 1.backup_script.rb <source_directory> <backup_directory>
   
