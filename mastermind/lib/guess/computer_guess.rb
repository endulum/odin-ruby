require "colorize"
require_relative "../colors"
require_relative "guess_input"
require_relative "guess_scoring"

# store a guess and its score, if computer is codebreaker
class ComputerGuess
  include GuessInput
  include GuessScoring

  attr_reader :guess, :score

  def initialize(input, answer)
    @guess = input
    puts "The computer guessed: #{
      Colors.to_list_string(Colors.code_to_array(@guess))
    }".colorize({ mode: :bold })
    @score = GuessScoring.calculate(guess, answer)
    GuessScoring.print_feedback(@score) unless defined?(RSpec)
  end
end
