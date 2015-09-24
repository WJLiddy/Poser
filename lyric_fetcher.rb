require 'mechanize'
class LyricFetcher

	@@mechanizer = Mechanize.new

  def self.fetch(artist,title)
    title_underscore = title.gsub(" ","_")
    fetch_web("http://lyrics.wikia.com/wiki/#{artist}:#{title_underscore}")
  end

  def self.fetch_web(url)
    page = @@mechanizer.get(url)
    begin
      html = Nokogiri::HTML(page.content)
      raw_lyrics = html.css('body').css('div')[2].css('section')[0].css('div')[1].css('article')[0].css('div')[0].css('div#WikiaArticle').css('div#mw-content-text').css('div[class=lyricbox]').to_s
      start_lyrics_br = raw_lyrics.index("</script>") + "</script>".size
      end_lyrics_br = raw_lyrics.index("<!--") - 1 
    rescue
      raise NoLyricsError.new("No lyrics for #{url}") 
    end
    raw_lyrics.to_s[start_lyrics_br..end_lyrics_br].gsub("<br>","\n").downcase
  end

end

NoLyricsError = Class.new(RuntimeError)
