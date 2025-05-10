require "colorize"
require_relative "colors"

# helper methods for interaction with the command line
module CLI
  def self.print_unless_rspec(string)
    print string unless defined?(RSpec)
  end

  def self.print_all_unless_rspec(array)
    array.each do |string|
      print_unless_rspec(string)
    end
  end

  def self.read_input(prefix = "❯ ", color = :white)
    print "\n#{prefix}".colorize(color: color)
    gets.chomp
  end
end
