require 'fileutils'
require 'date'

class FileTypeIdentifier
  def initialize(script_location)
    @script_location = File.expand_path(script_location)
    @log_file = File.join(@script_location, "1.backup_script_actions_logs.txt")
    @info_file = File.join(@script_location, "2.identified_files.txt")
  end

  def find_latest_backup_folder
    unless File.exist?(@log_file)
      puts "❌ Backup log file not found: #{@log_file}"
      exit 1
    end
    
    last_destination = nil
    File.readlines(@log_file).each do |line|
      if line.start_with?("Destination:")
        last_destination = line.split("Destination:").last.strip
      end
    end
    
    unless last_destination && Dir.exist?(last_destination)
      puts "❌ Could not find a valid backup destination from log file."
      exit 1
    end
    
    last_destination
  end

  def identify_file_types
    backup_folder = find_latest_backup_folder
    puts "📂 Scanning latest backup folder: #{backup_folder}"
    file_types = Hash.new(0)
    
    Dir.glob(File.join(backup_folder, '**', '*')).each do |file|
      next if File.directory?(file)
      ext = File.extname(file).downcase
      ext = "(no extension)" if ext.empty?
      file_types[ext] += 1
    end
    
    File.open(@info_file, 'w') do |file|
      file_types.sort_by { |_ext, count| -count }.each do |ext, count|
        file.puts "#{ext}: #{count} files"
      end
    end
    
    puts "✅ File type identification complete. Results saved in #{@info_file}"
    display_results(file_types)
  end

  private

  def display_results(file_types)
    puts "\n📂 File Type Summary:\n"
    file_types.sort_by { |_ext, count| -count }.each do |ext, count|
      puts "#{ext}: #{count} files"
    end
  end
end

# CLI Execution
script_location = File.dirname(__FILE__)
file_identifier = FileTypeIdentifier.new(script_location)
file_identifier.identify_file_types
