require 'fileutils'

class FileMover
  def initialize(script_location, jekyll_root)
    @script_location = File.expand_path(script_location)
    @jekyll_root = File.expand_path(jekyll_root)
    @info_file = File.join(@script_location, "2.identified_files.txt")
    @log_file = File.join(@script_location, "3.1.file_movement_log.txt")
    @backup_log_file = File.join(@script_location, "1.backup_script_actions_logs.txt")
    @backup_folder = nil
  end

  def find_latest_backup_folder
    unless File.exist?(@backup_log_file)
      puts "❌ Backup log file not found: #{@backup_log_file}"
      exit 1
    end
    
    last_destination = nil
    File.readlines(@backup_log_file).each do |line|
      if line.start_with?("Destination:")
        last_destination = line.split("Destination:").last.strip
      end
    end
    
    unless last_destination && Dir.exist?(last_destination)
      puts "❌ Could not find a valid backup destination from log file."
      exit 1
    end
    
    @backup_folder = last_destination
    puts "📂 Latest backup found: #{@backup_folder}"
  end

  def move_files
    find_latest_backup_folder
    puts "📂 Moving files from latest backup: #{@backup_folder} to Jekyll root: #{@jekyll_root}"
    movements = []
    
    unless File.exist?(@info_file)
      puts "❌ Identified files list not found: #{@info_file}"
      exit 1
    end
    
    Dir.glob(File.join(@backup_folder, '**', '*')).each do |file|
      next if File.directory?(file)
      ext = File.extname(file).downcase
      ext = "no_extension" if ext.empty?
      ext_folder = determine_jekyll_folder(ext)
      
      target_folder = File.join(@jekyll_root, ext_folder)
      FileUtils.mkdir_p(target_folder)
      
      target_path = File.join(target_folder, File.basename(file))
      FileUtils.mv(file, target_path)
      movements << { source: file, destination: target_path }
      puts "✅ Moved: #{file} -> #{target_path}"
    end
    
    log_file_movements(movements)
    puts "🚀 File movement completed!"
  end

  private

  def determine_jekyll_folder(ext)
    case ext
    when ".html"
      "_pages"
    when ".jpg", ".jpeg", ".png", ".gif"
      "assets/images"
    when ".css"
      "assets/css"
    when ".js"
      "assets/js"
    else
      "miscellaneous"
    end
  end

  def log_file_movements(movements)
    File.open(@log_file, 'w') do |log|
      log.puts "File Movement Log - #{Time.now}"
      movements.each do |entry|
        log.puts "#{entry[:source]} -> #{entry[:destination]}"
      end
    end
    puts "📝 File movements logged in #{@log_file}"
  end
end

# CLI Execution
if ARGV.length != 1
  puts "Usage: ruby 3.1_move_files.rb <jekyll_root_directory>"
  exit 1
end

script_location = File.dirname(__FILE__)
jekyll_root_directory = ARGV[0]

file_mover = FileMover.new(script_location, jekyll_root_directory)
file_mover.move_files
