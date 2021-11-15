require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    alphabet = ('A'..'Z').to_a
    @letters = []
    10.times do
      @letters << alphabet.sample
    end
    return @letters
  end

  def score
    @answer = params[:word].capitalize
    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    data = URI.open(url)
    resp = data.read
    @response = JSON.parse(resp)

    @final_answer = if @response.key?("error")
                    "Sorry but #{@answer} is not in the grid"
                  elsif @response["found"] == false
                    "Sorry but #{@answer} does not seem to be an English word"
                  else
                    "Well done! #{@answer} is a valid English word!"
                  end
  end
end
