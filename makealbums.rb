require 'fileutils'
require 'pathname'

FLAT_MUSIC = '/Users/julio/Dropbox/Flat Music/New Music/- New Music -'

def capture_albums
  albums = Hash.new(0)
  Dir["#{FLAT_MUSIC}/**/*"].each do |file|
    next unless File.file?(file)

    path   = Pathname.new(file)
    parts  = path.basename.to_s.split('~')
    album  = parts[0]
    puts "Album: #{album}"
    FileUtils::mkdir_p("#{FLAT_MUSIC}/#{album}")
    if file != "#{FLAT_MUSIC}/#{album}/#{path.basename}"
      begin
        FileUtils::mv(file, "#{FLAT_MUSIC}/#{album}/#{path.basename}")
      rescue => error
        puts "ERROR: #{error.message}"
      end
    end
    albums[album] += 1
  end
  albums
end

albums = capture_albums
puts ">>>>>> #{albums.size} <<<<<<"
puts
albums.each do |album|
  FileUtils::mkdir_p("/Users/julio/Dropbox/Flat Music/FlatMusic/#{album[0]}")
  # puts album[0]
end
