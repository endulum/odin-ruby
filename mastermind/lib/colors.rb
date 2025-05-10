require "colorize"

# helper methods for Mastermind colors
module Colors
  # mapping color name strings to Colorizer symbols
  @colors = {
    "red" => :red,
    "blue" => :blue,
    "green" => :green,
    "yellow" => :yellow,
    "magenta" => :magenta
  }

  ### return an array of strings

  # all Mastermind colors, as an array of strings
  def self.all
    @colors.keys
  end

  # sample random Mastermind colors, as an array of strings
  def self.sample(amount = 4)
    Array.new(amount) { all.sample }
  end

  ### return a string for printing

  # colorized name string of one Mastermind color
  def self.to_string(string)
    string.colorize({ color: to_symbol(string) }) if to_symbol(string)
  end

  # colorized name string of all Mastermind colors in a sentence-appropriate phrase
  def self.all_to_list_string
    all[0..-2].map do |key|
      to_string(key)
    end.join(", ") + ", and #{to_string(all[-1])}"
  end

  ### return a Colorizer symbol

  # color symbol of one Mastermind color
  def self.to_symbol(string)
    @colors[string]
  end

  ### predicates

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
end
