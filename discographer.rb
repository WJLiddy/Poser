require 'mechanize'
require 'fileutils'
require 'set'
require_relative 'lyric_fetcher'
class Discographer

	@@mechanizer = Mechanize.new

	def self.add(artist)
    page = @@mechanizer.get("http://lyrics.wikia.com/wiki/#{artist}")
    html = Nokogiri::HTML(page.content)
    raw_albums = html.css('body').css('div')[2].css('section')[0].css('div')[1].css('article')[0].css('div#WikiaMainContentContainer').css('div#mw-content-text')


    #Time to iterate over every <o1> which contains the info we need.
    song_links = Set.new
    raw_albums.css('ol').each do |album|
        album.css('li').each do |song|
            song_links << song.css('b').css('a').first["href"]
        end
    end

    puts "Found #{song_links.size} songs for #{artist}"

    FileUtils.mkdir_p("Artists/" +artist)
    song_links.each_with_index do |link,i|

        puts "Processing #{i+1} of #{song_links.size}"
        $stdout.flush
        begin
            lyrics = LyricFetcher.fetch_web("http://lyrics.wikia.com" + link)
        rescue NoLyricsError
            puts "Lyrics do not exist for #{link}"
            next
        end

        File.open("Artists/#{artist}/#{i.to_s}.txt", 'w') {|f| f.write(lyrics) }

    end
  end
end

#Usage: $stdout.flush