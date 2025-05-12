require "colorize"
require_relative "guess_input"
require_relative "guess_scoring"

# store a guess and its score, if computer is codebreaker
class ComputerGuess
  include GuessInput
  include GuessScoring

  attr_reader :guess, :score

  def initialize(input, answer)
    @guess = input
    @score = GuessScoring.calculate(guess, answer)
  end
end
