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
      print_history_table
      if correct?(guess)
        CLI.print_bold("You guessed correctly! The code was #{@code}. You took #{@guesses.length} guesses.")
        break
      end
    end
  end

  # rubocop: disable Metrics/MethodLength
  def self.compare(guess, answer)
    feedback = []
    answer_copy = answer.map(&:clone)
    # find correct colors in correct spots
    guess.each_with_index do |color, index|
      if color == answer_copy[index]
        feedback.push("correct")
        answer_copy[index] = nil
      end
    end
    # find correct colors in wrong spots
    guess.each do |color|
      if answer_copy.include?(color)
        feedback.push("almost")
        answer_copy[answer_copy.find_index(color)] = nil
      end
    end
    feedback
  end
  # rubocop: enable Metrics/MethodLength

  private

  # print history table
  def print_history_table
    print history_start
    @guesses.each_with_index do |guess, index|
      print history_row_count(index)
      print history_row_guess(guess[:guess])
      print history_row_feedback(guess[:feedback])
    end
    print "   ╚═══════════╩═══════════╝\n".colorize({ color: :gray })
  end

  def history_start
    "   ╔═ ".colorize(
      { color: :gray }
    ) + "Guesses".colorize(
      { color: :white, mode: :bold }
    ) + " ═╦═══════════╗\n".colorize(
      { color: :gray }
    )
  end

  def history_row_count(index)
    (index + 1).to_s.rjust(2, " ").colorize(
      { color: :white, mode: :bold }
    ) + " ║  ".colorize({ color: :gray })
  end

  def history_row_guess(guess)
    guess.map do |color|
      "●".colorize({ color: Colors.to_symbol(color) })
    end.join(" ") + "  ║  ".colorize({ color: :gray })
  end

  def history_row_feedback(feedback)
    feedback
      .join(" ")
      .gsub("correct", "✓")
      .gsub("almost", "✗")
      .ljust(7, " ")
      .colorize({ color: :white }) + "  ║\n".colorize({ color: :gray })
  end

  # prompt a guess, evaluate, record, and return it
  def prompt_guess
    guess = parse_guess(CLI.read_input) until guess
    CLI.print_bold("You guessed: #{guess.map do |c|
      Colors.to_colorized_string(c)
    end.join(', ')}")
    feedback = self.class.compare(guess, @code)
    @guesses.push({ guess: guess, feedback: feedback })
    guess
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
