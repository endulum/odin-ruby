require "colorize"
require_relative "../colors"
require_relative "guess_input"
require_relative "guess_scoring"

# store a guess and its score, if human is codebreaker
class HumanGuess
  include GuessInput
  include GuessScoring

  attr_reader :guess, :score

  def initialize(answer)
    @guess = GuessInput.prompt_for_code
    puts "You guessed: #{
      Colors.to_list_string(Colors.code_to_array(@guess))
    }".colorize({ mode: :bold })
    @score = GuessScoring.calculate(guess, answer)
  end
end
