require 'fileutils'

class HtmlTidyUp
  def initialize(jekyll_pages_folder, script_location)
    @jekyll_pages_folder = File.expand_path(jekyll_pages_folder)
    @log_file = File.join(script_location, "4.0.tidy_log.txt")
  end

  def tidy_html_files
    unless Dir.exist?(@jekyll_pages_folder)
      puts "❌ Jekyll _pages folder not found: #{@jekyll_pages_folder}"
      exit 1
    end
    
    puts "🧹 Tidying up HTML files in #{@jekyll_pages_folder}"
    modifications = []

    Dir.glob(File.join(@jekyll_pages_folder, '**', '*.html')).each do |file|
      temp_file = "#{file}.tidy"
      system("tidy -q -modify -indent --indent-spaces 2 --wrap 0 --tidy-mark no #{file} 2>/dev/null")
      
      if File.exist?(file)
        modifications << file
        puts "✅ Tidied: #{file}"
      end
    end

    log_tidy_files(modifications)
    puts "🚀 Tidy process completed!"
  end

  private

  def log_tidy_files(modifications)
    File.open(@log_file, 'w') do |log|
      log.puts "Tidy Log - #{Time.now}"
      modifications.each { |file| log.puts "Tidied: #{file}" }
    end
    puts "📝 Tidy process logged in #{@log_file}"
  end
end

# CLI Execution
if ARGV.length != 1
  puts "Usage: ruby 4.0_tidy_html.rb <_pages_directory>"
  exit 1
end

script_location = File.dirname(__FILE__)
jekyll_pages_folder = ARGV[0]

tidy_up = HtmlTidyUp.new(jekyll_pages_folder, script_location)
tidy_up.tidy_html_files
