require 'marky_markov'

class Markov

	def self.create(artist)
		markov = MarkyMarkov::Dictionary.new("Artists/#{artist}/markov",1) 
		songs = Dir["Artists/#{artist}/*.txt"]
		songs.each_with_index do |song, i|
			 puts "Processing #{i+1} of #{songs.size}"
       $stdout.flush
			markov.parse_file song
		end
		markov.save_dictionary! # Saves the modified dictionary/creates one if it didn't exist.
	end

	def initialize(artist)
		throw "Markov for #{artist} does not exist" unless File.exist?("Artists/#{artist}/markov.mmd")
		@markov = MarkyMarkov::Dictionary.new("Artists/#{artist}/markov",1) 
	end

	#nned avg lyric line length
	def sentence
		@markov.generate_100_words
	end
end

