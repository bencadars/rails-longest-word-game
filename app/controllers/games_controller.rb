require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    attempt = params[:word]
    grid = params[:grid]
      if attempt.upcase.chars.all? { |letter| attempt.upcase.count(letter) <= grid.count(letter) }
        url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
        response = URI.open(url).read
        json_data = JSON.parse(response)
        if json_data["found"] == true
          score = attempt.length
          @result = {
            score: score,
            message: "well done"
          }
        else
          @result = {
            score: 0,
            message: "not an english word"
          }
        end
      else
        @result = {
          score: 0,
          message: "not in the grid"
        }
      end
    end
end
