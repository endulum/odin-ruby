require "colorize"

# handles getting input and printing with the command line
module CLI
  def self.testing?
    defined?(RSpec)
  end

  def self.bprint(string)
    puts string.colorize({ mode: :bold }) unless testing?
  end

  def self.bprint_all(array)
    print array.join("\n").colorize({ mode: :bold }) unless testing?
  end

  def self.read_input(text = nil, prefix = "❯ ", color = :white)
    raise "Should not be called in unit testing" if testing?

    print "\n#{text ? "#{text} " : ''}#{prefix}".colorize(color: color)
    gets.chomp
  end

  def self.prompt_answer(accepted_inputs = %w[y n])
    loop do
      input = read_input
      return input if accepted_inputs.include?(input)

      CLI.bprint "Not a valid input: #{input}. Accepted inputs are #{accepted_inputs}"
    end
  end
end
