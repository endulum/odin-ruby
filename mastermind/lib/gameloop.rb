require "colorize"
require "pry-byebug"
require_relative "cli"
require_relative "loops/human_loop"
require_relative "loops/computer_loop"

# the base loop for the program
class Gameloop
  def initialize
    puts "Welcome to Mastermind.".colorize({ mode: :bold })
    loop do
      command = prompt_command
      play(command)
      play_again = prompt_play_again
      unless play_again
        puts "Goodbye!".colorize({ mode: :bold })
        break
      end
    end
  end

  def print_prompt_command
    [
      "\nType \"breaker\" to be the codebreaker, and try to figure out the computer's code.",
      "Type \"maker\" to be the codemaker, and watch the computer solve your code."
    ].each do |string|
      puts string.colorize({ mode: :bold })
    end
  end

  def prompt_command
    print_prompt_command
    command = CLI.read_input
    valid_commands = %w[breaker maker]
    loop do
      break if valid_commands.include?(command)

      puts "Invalid command: #{command}"
      print_prompt_command
      command = CLI.read_input
    end
    command
  end

  def prompt_play_again
    puts "\nWant to play again? (y/n)".colorize({ mode: :bold })
    answer = CLI.read_input
    valid_answers = %w[y n]
    loop do
      break if valid_answers.include?(answer)

      puts "Invalid answer: #{answer}"
      puts "Please type 'y' (yes) or 'n' (no)".colorize({ mode: :bold })
      answer = CLI.read_input
    end
    answer == "y"
  end

  def play(command)
    if command == "breaker"
      game = HumanLoop.new
      game.play
    elsif command == "maker"
      game = ComputerLoop.new
      game.play
    end
  end
end
