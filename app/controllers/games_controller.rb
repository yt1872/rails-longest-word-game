require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array.new(9) { ('A'..'Z').to_a.sample }
  end

  def score
    @answer = params[:answer].upcase
    @letters = params[:letters]
    @word_english = english?(@answer)
    @in_the_grid = grid?(@answer, @letters)
    if @word_english == true
      @results = "your word is valid and it's english"
    elsif @in_the_grid == true
      @results = "your word is in the grid and its valid"
    else
      @results = "your word is neither english nor in the grid"
    end
  end

  def english?(answer)
    url = "https://wagon-dictionary.herokuapp.com/#{answer}"
    user_serialized = open(url).read
    json = JSON.parse(user_serialized)
    return json["found"]
  end

  def grid?(answer, letters)
    @answer.chars.all? { |letter| @answer.count(letter) <= @letters.count(letter) }
  end

  # def run_game(answer, letters, start_time, end_time)
  #   time_taken = end_time - start_time
  #   score = (answer.size / time_taken) * 100
  #   if !letters?(@answer.upcase, letters)
  #     return { score: 0, time: time_taken, message: "not in the grid" }
  #   elsif !english?(@answer.upcase)
  #     return { score: 0, time: time_taken, message: "not an english word" }
  #   else
  #     return { score: score, time: time_taken, message: "well done" }
  #   end
  # end
end
