require 'fileutils'
require 'date'

class BackupScript
  def initialize(source, backup_destination, script_location)
    timestamp = Time.now.strftime('%Y%m%d%H%M') # YYYYMMDDHHMM format
    @source = File.expand_path(source)
    @backup_destination = File.join(File.expand_path(backup_destination), "#{timestamp}_backup")
    @script_location = File.expand_path(script_location)
    @log_file = File.join(@script_location, "1.backup_script_actions_logs.txt")
    @info_file = File.join(@script_location, "1.backup_info.txt")
  end

  def create_backup
    puts "📦 Creating backup of #{@source}..."
    FileUtils.mkdir_p(@backup_destination)
    FileUtils.cp_r(Dir.glob(File.join(@source, '*')), @backup_destination)
    puts "✅ Backup completed! Files copied to #{@backup_destination}"
    generate_info_file
    log_backup_action
  end

  private

  def generate_info_file
    files = Dir.glob(File.join(@source, '**', '*')).reject { |f| File.directory?(f) }
    File.open(@info_file, 'w') do |file|
      files.each { |f| file.puts f }
    end
    puts "📄 Backup information written to #{@info_file}"
  end

  def log_backup_action
    File.open(@log_file, 'w') do |log|
      log.puts "Backup Run: #{Time.now}"
      log.puts "Source: #{@source}"
      log.puts "Destination: #{@backup_destination}"
    end
    puts "📝 Backup action logged in #{@log_file}"
  end
end

# CLI Argument Parsing
if ARGV.length != 2
  puts "Usage: ruby 1_backup_script.rb <source_directory> <backup_directory>"
  exit 1
end

source_directory = ARGV[0]
backup_directory = ARGV[1]
script_location = File.dirname(__FILE__)

backup_script = BackupScript.new(source_directory, backup_directory, script_location)
backup_script.create_backup