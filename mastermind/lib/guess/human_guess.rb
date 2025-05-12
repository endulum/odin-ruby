require "colorize"
require_relative "guess_input"
require_relative "guess_scoring"

# store a guess and its score, if human is codebreaker
class HumanGuess
  include GuessInput
  include GuessScoring

  attr_reader :guess, :score

  def initialize(answer)
    @guess = GuessInput.prompt_for_code
    @score = GuessScoring.calculate(guess, answer)
  end
end
