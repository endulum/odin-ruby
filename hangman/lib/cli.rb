require "colorize"

# handles getting input and printing with the command line
module CLI
  def self.bprint(string)
    puts string.colorize({ mode: :bold })
  end

  def self.bprint_all(array)
    print array.join("\n").colorize({ mode: :bold })
  end

  def self.read_input(prefix = "❯ ", color = :white)
    print "\n#{prefix}".colorize(color: color)
    gets.chomp
  end
end
