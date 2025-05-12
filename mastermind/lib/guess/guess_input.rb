require "colorize"
require_relative "../colors"
require_relative "../cli"

# collects and parses guess input from human codebreaker
module GuessInput
  def self.prompt_for_code
    code = parse(CLI.read_input) until code
    code
  end

  # returns input as code, or nil if errors.
  def self.parse(input)
    array = input.split
    is_four_colors_long = array.length == 4
    is_all_valid_colors = Colors.array_of_colors?(array)
    return Colors.array_to_code(array) if is_four_colors_long && is_all_valid_colors

    print_guess_errors(array, is_four_colors_long, is_all_valid_colors) unless defined?(RSpec)
    nil
  end

  # TODO: make below private

  # collect input guess errors into an array to print
  def self.print_guess_errors(array, is_four_colors_long, is_all_valid_colors)
    messages = ["There were some errors with your input, which was: #{array}\n"]
    messages.push("- You need to choose 4 colors. You've chosen #{array.length}.\n") unless is_four_colors_long
    messages.push("- Please only use valid colors: #{Colors.all_to_list_string}.\n") unless is_all_valid_colors
    messages.each { |msg| print msg.colorize({ mode: :bold }) }
  end
end
