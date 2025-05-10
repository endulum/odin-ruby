require "colorize"
require_relative "colors"

# helper methods for interaction with the command line
module CLI
  def self.print_bold(string)
    puts string.colorize({ mode: :bold })
  end

  def self.print_bold_all(array)
    array.each do |string|
      print_bold(string)
    end
  end

  def self.read_input(prefix = "❯ ", color = :white)
    print "\n#{prefix}".colorize(color: color)
    gets.chomp
  end
end
