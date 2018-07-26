require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = generate_grid(10);
  end

  def score
    @score = params[:word]
    @letters = params[:letters]

    if included?(params[:word].upcase, @letters)
      if english_word?(params[:word])
        @sentence = "Congratulations!"
      else
        @sentence = "Not an english_word"
      end
    else
        @sentence = "Not in the grid"
    end
  end

  def generate_grid(grid_size)
    Array.new(grid_size) { ('A'..'Z').to_a.sample }
  end

  def included?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

 def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end
end
