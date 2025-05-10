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

  # colorized identifying string (red "red", blue "blue", etc)
  def self.to_colorized_string(string)
    string.colorize({ color: to_symbol(string) }) if to_symbol(string)
  end

  # colorized arbitrary string
  def self.color_text(string, color)
    string.colorize({ color: to_symbol(color) }) if to_symbol(string)
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

  # sample random colors
  def self.sample(amount = 4)
    Array.new(amount) { all.sample }
  end
end
