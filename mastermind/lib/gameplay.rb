require "colorize"
require_relative "colors"
require_relative "cli"

# creates games
class Gameplay
  def initialize
    @code = Colors.sample
    @guesses = []
  end

  # the game loop
  def play
    loop do
      guess = prompt_guess
      if correct?(guess)
        CLI.print_bold("You guessed correctly! The code was #{@code}. You took #{@guesses.length} guesses.")
        break
      end
    end
  end

  private

  # prompt a guess, evaluate, record, and return it
  def prompt_guess
    guess = parse_guess(CLI.read_input) until guess
    CLI.print_bold("You guessed: #{guess.map do |c|
      Colors.to_colorized_string(c)
    end.join(', ')}")
    feedback = feedback_correct_guesses(guess)
    p feedback
    @guesses.push({ guess: guess, feedback: feedback })
    guess
  end

  # give feedback for correct colors in correct spots
  def feedback_correct_guesses(guess)
    feedback = []
    code_copy = @code.map(&:clone)
    guess.each_with_index do |color, index|
      if color == code_copy[index]
        feedback.push("correct")
        code_copy[index] = nil
      end
    end
    feedback.concat feedback_almost_guesses(guess, code_copy)
  end

  # give feedback for correct colors in wrong spots
  def feedback_almost_guesses(guess, code_copy)
    feedback = []
    guess.each do |color|
      if code_copy.include?(color)
        feedback.push("almost")
        code_copy[code_copy.find_index(color)] = nil
      end
    end
    feedback
  end

  # compare the guess to correct code
  def correct?(guess)
    guess == @code
  end

  # parse input into a guess, or print errors if input is invalid
  def parse_guess(input)
    array = input.split
    is_four_colors_long = array.length == 4
    is_all_valid_colors = Colors.array_of_colors?(array)
    return array unless !is_four_colors_long || !is_all_valid_colors

    messages = ["Errors with your guess: #{array}"]
    messages.push("- You need to choose 4 colors. You've chosen #{array.length}.") unless is_four_colors_long
    messages.push("- Please only use valid colors: #{Colors.all_to_colorized_string}") unless is_all_valid_colors
    CLI.print_bold_all(messages)
    nil
  end
end
