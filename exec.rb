require_relative 'lyric_fetcher'
require_relative 'discographer'
require_relative 'markov'
require_relative 'grammar'

def make (artist)
	Discographer.add(artist)
end

def create_wall(artist)
	Markov.create(artist)
	m = Markov.new(artist)
	wall = " "
	10.times do 
		wall << m.sentence
	end
	wall
end

#Usage
#make("DragonForce")
#puts create_wall("DragonForce")
