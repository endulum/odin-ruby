require "colorize"
require_relative "colors"
require_relative "cli"

# stores color combinations in "guesses" with feedback
class Guess
  attr_reader :guess, :feedback

  def initialize(answer)
    @guess = Guess.parse(CLI.read_input) until @guess
    @feedback = Guess.compare(@guess, answer.map(&:clone))
  end

  # parse input into a guess, or return nothing and print errors if input is invalid
  def self.parse(input)
    array = input.split
    is_four_colors_long = array.length == 4
    is_all_valid_colors = Colors.array_of_colors?(array)
    return array unless !is_four_colors_long || !is_all_valid_colors

    unless defined?(RSpec)
      print_guess_errors(
        array, is_four_colors_long, is_all_valid_colors
      )
    end
    nil
  end

  # generate feedback from a guess based on the correct answer
  def self.compare(guess, answer)
    feedback_correct(guess, answer) + feedback_almost(guess, answer)
  end

  # find correct colors in correct spots
  def self.feedback_correct(guess, answer)
    feedback = []
    guess.each_with_index do |color, index|
      if color == answer[index]
        feedback.push("correct")
        answer[index] = nil
      end
    end
    feedback
  end

  # find correct colors in wrong spots
  def self.feedback_almost(guess, answer)
    feedback = []
    guess.each do |color|
      if answer.include?(color)
        feedback.push("almost")
        answer[answer.find_index(color)] = nil
      end
    end
    feedback
  end

  # collect guess errors into an array for printing
  def self.print_guess_errors(array, is_four_colors_long, is_all_valid_colors)
    messages = ["There were some errors with your guess, which was: #{array}\n"]
    messages.push("- You need to choose 4 colors. You've chosen #{array.length}.\n") unless is_four_colors_long
    messages.push("- Please only use valid colors: #{Colors.all_to_list_string}.\n") unless is_all_valid_colors
    CLI.print_all_unless_rspec(messages.map { |msg| msg.colorize({ mode: :bold }) })
  end

  private_class_method :print_guess_errors
  private_class_method :feedback_correct
  private_class_method :feedback_almost
end
