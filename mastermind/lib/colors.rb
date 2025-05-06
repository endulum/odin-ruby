require "colorize"

# helper methods for Mastermind colors
module Colors
  @colors = {
    "red" => :red,
    "blue" => :blue,
    "green" => :green,
    "yellow" => :yellow,
    "magenta" => :magenta
  }

  # all Mastermind colors
  def self.all
    @colors.keys
  end

  # colorized string of all Mastermind colors in a sentence-appropriate phrase
  def self.all_to_colorized_string
    all[0..-2].map do |key|
      to_colorized_string(key)
    end.join(", ") + ", and #{to_colorized_string(all[-1])}"
  end

  # color symbol of one Mastermind color
  def self.to_symbol(string)
    @colors[string]
  end

  # colorized string of one Mastermind color
  def self.to_colorized_string(string)
    string.colorize({ color: to_symbol(string) }) if to_symbol(string)
  end

  # is given string a Mastermind color?
  def self.color?(string)
    @colors.key?(string)
  end

  # is given array all Mastermind colors?
  def self.array_of_colors?(array)
    array.all? do |element|
      color?(element)
    end
  end

  # MOVE BELOW TO OWN MODULE, MAYBE

  # # asks for colors input
  # def self.prompt_colors
  #   input_colors = Colors.parse_input_colors(CLI.read_input) until input_colors

  #   # TODO: code to handle this as a "guess"
  #   guess = input_colors.map do |c|
  #     to_colorized_string(c)
  #   end.join(", ")
  #   CLI.print_bold("You guessed: #{guess}")
  # end

  # # parses input into Mastermind colors, or prints errors if input is invalid
  # def self.parse_input_colors(input)
  #   array = input.split
  #   is_four_colors_long = array.length == 4
  #   is_all_valid_colors = array_of_colors?(array)
  #   return array unless !is_four_colors_long || !is_all_valid_colors

  #   messages = ["Errors with your guess: #{array}"]
  #   messages.push("- You need to choose 4 colors. You've chosen #{array.length}.") unless is_four_colors_long
  #   messages.push("- Please only use valid colors: #{Colors.all_to_colorized_string}") unless is_all_valid_colors
  #   CLI.print_bold_all(messages)
  #   nil
  # end
end
