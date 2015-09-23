require_relative '../lyric_fetcher'
require 'rspec'

describe LyricFetcher do
 
  it "fetches songs and formats" do
   	expect(LyricFetcher.fetch("Napalm Death","You Suffer")).to eq"You suffer \nBut why?\n"
  end
 
end