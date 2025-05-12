require "colorize"
require_relative "../colors"
require_relative "../cli"
require_relative "../guess/guess_input"
require_relative "../guess/computer_guess"
require_relative "../cpu/computer_decision"

# gameloop for computer codebreaker
class ComputerLoop
  def initialize(max_guess_count = 10)
    @max_guess_count = max_guess_count
  end

  def play
    @computer_decision = ComputerDecision.new
    print_start
    init_fields
    print_guesses_left
    while @attempts.length < @max_guess_count
      attempt = make_attempt
      break if attempt.guess == @answer

      print_guesses_left
    end
  end

  private

  def init_fields
    @answer = GuessInput.prompt_for_code
    @attempts = []
  end

  def make_attempt
    wait_for_thinking
    attempt = ComputerGuess.new(@computer_decision.make_guess(@attempts.last), @answer)
    @attempts.push attempt
    print_win if attempt.guess == @answer
    attempt
  end

  def wait_for_thinking
    puts "\nThe computer is thinking..."
    sleep(2)
  end

  def print_start
    [
      "\nEnter a code of four colors, and the computer will try to guess it.",
      "The available colors are #{Colors.all_to_list_string}.",
      "Proper format is each color separated by space, e.g. 'red blue red blue'."
    ].each do |string|
      puts string.colorize({ mode: :bold })
    end
  end

  def print_guesses_left
    @guesses_left = @max_guess_count - @attempts.length
    if @guesses_left.zero?
      puts "The computer lost! It out of guesses. The code was #{
      Colors.to_list_string(Colors.code_to_array(@answer))
    }.".colorize({ mode: :bold })
    else
      puts "The computer has #{@max_guess_count - @attempts.length} guesses left.".colorize({ mode: :bold })
    end
  end

  def print_win
    puts "The computer guessed correctly! It took #{@attempts.length} guesses."
      .colorize({ mode: :bold })
  end
end
