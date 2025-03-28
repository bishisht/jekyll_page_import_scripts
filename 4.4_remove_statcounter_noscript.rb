#!/usr/bin/env ruby

# Check for directory argument
abort "Usage: ruby #{__FILE__} <directory>" if ARGV.empty?

dir = ARGV[0]
abort "Error: Directory '#{dir}' not found" unless Dir.exist?(dir)

# Regular expression to match the <noscript> block
noscript_regex = /<noscript>.*?<a href="http:\/\/statcounter\.com\/".*?<\/noscript>/m

# Counters
changed_files = 0
unchanged_files = 0

# Process HTML files
Dir.glob(File.join(dir, '**', '*.html')).each do |file|
  content = File.read(file)
  
  # Check if the <noscript> block exists
  if content.match?(noscript_regex)
    cleaned = content.gsub(noscript_regex, '')
    File.write(file, cleaned)
    changed_files += 1
    puts "✅ Removed from: #{file}"
  else
    unchanged_files += 1
    puts "❌ Not found in: #{file}"
    # Debugging: Show full noscript block if present
    noscript_start = content.index('<noscript>')
    if noscript_start
      noscript_end = content.index('</noscript>', noscript_start)
      if noscript_end
        noscript_end += '</noscript>'.length
        snippet = content[noscript_start..noscript_end - 1]
        puts "  Found this instead: #{snippet}"
        # Check for invisible characters
        hex_dump = snippet.chars.map { |c| c.ord.to_s(16).rjust(2, '0') }.join(' ')
        puts "  Hex dump: #{hex_dump}"
      else
        puts "  Incomplete <noscript> tag found."
      end
    else
      puts "  No <noscript> tags found in this file."
    end
  end
end

# Display summary
puts "\nSummary:"
puts "Number of changed files: #{changed_files}"
puts "Number of unchanged files: #{unchanged_files}"
puts "StatCounter noscript removal process complete!"