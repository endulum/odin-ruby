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

  # prints and colorizes a color string
  def self.to_colorized_string(key)
    key.colorize({ color: @colors[key] })
  end

  # prints and colorizes all Mastermind colors in a sentence-appropriate phrase
  def self.all_to_colorized_string
    @colors.keys[0..-2].map do |key|
      to_colorized_string(key)
    end.join(", ") + ", and #{to_colorized_string(@colors.keys[-1])}"
  end

  # asks for colors input
  def self.prompt_colors
    input_colors = Colors.parse_input_colors(CLI.read_input) until input_colors

    # TODO: code to handle this as a "guess"
    guess = input_colors.map do |c|
      to_colorized_string(c)
    end.join(", ")
    CLI.print_bold("You guessed: #{guess}")
  end

  # parses input into Mastermind colors, or prints errors if input is invalid
  def self.parse_input_colors(input)
    array = input.split
    is_four_colors_long = array.length == 4
    is_all_valid_colors = array_of_colors?(array)
    return array unless !is_four_colors_long || !is_all_valid_colors

    messages = ["Errors with your guess: #{array}"]
    messages.push("- You need to choose 4 colors. You've chosen #{array.length}.") unless is_four_colors_long
    messages.push("- Please only use valid colors: #{Colors.all_to_colorized_string}") unless is_all_valid_colors
    CLI.print_bold_all(messages)
    nil
  end

  # is given string a Mastermind color?
  def self.color?(string)
    @colors.key?(string)
  end

  # is given string array an array of Mastermind colors?
  def self.array_of_colors?(array)
    array.all? do |element|
      color?(element)
    end
  end
end
