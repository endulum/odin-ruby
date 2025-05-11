require "colorize"

# helper methods for Mastermind colors
module Colors
  # mapping names to Colorizer symbols
  @colors = {
    "red" => :red,
    "blue" => :blue,
    "green" => :green,
    "yellow" => :yellow,
    "magenta" => :magenta
  }

  # all color strings
  def self.all
    @colors.keys
  end

  def self.sample(amount = 4)
    Array.new(amount) { all.sample }
  end

  ### Colorizer helpers

  # convert name to Colorizer symbol
  def self.name_to_symbol(name)
    @colors[name]
  end

  # convert name to Colorized name string
  def self.name_to_string(string)
    string.colorize({ color: name_to_symbol(string) }) if name_to_symbol(string)
  end

  # colorized names of colors given color array in a comma-separated list
  def self.to_list_string(array)
    array.map do |key|
      name_to_string(key)
    end.join(", ")
  end

  # same as above, but all colors and in a sentence-appropriate phrase
  def self.all_to_list_string
    all[0..-2].map do |key|
      name_to_string(key)
    end.join(", ") + ", and #{name_to_string(all[-1])}"
  end

  ### conversions between numbers and names

  ## convert number to name
  def self.number_to_color(index)
    @colors.keys[index - 1]
  end

  # convert name to number
  def self.color_to_number(color)
    @colors.keys.index(color) + 1
  end

  # convert array of names to string of numbers
  def self.array_to_code(array)
    array.map do |color|
      color_to_number(color)
    end.join
  end

  # convert string of numbers to array of names
  def self.code_to_array(code)
    code.chars.map do |number|
      number_to_color(number.to_i)
    end
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
