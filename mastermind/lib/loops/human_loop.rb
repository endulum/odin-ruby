require "colorize"
require_relative "../colors"
require_relative "../cli"
require_relative "../guess/human_guess"

# gameloop for human codebreaker
class HumanLoop
  def initialize(max_guess_count = 10)
    @max_guess_count = max_guess_count
    @answer = Array.new(4).map { "12345".chars.sample }.join
    @attempts = []
  end

  def play
    print_start
    print_guesses_left
    while @attempts.length < @max_guess_count
      attempt = make_attempt
      break if attempt.guess == @answer

      print_feedback(attempt.score)
    end
  end

  private

  def make_attempt
    attempt = HumanGuess.new(@answer)
    @attempts.push attempt
    print_win if attempt.guess == @answer
    attempt
  end

  def print_start
    [
      "To make a guess, enter the names of the four colors of your guess.",
      "The available colors are #{Colors.all_to_list_string}.",
      "Proper format is each color separated by space, e.g. 'red blue red blue'."
    ].each do |string|
      puts string.colorize({ mode: :bold })
    end
  end

  def print_guesses_left
    @guesses_left = @max_guess_count - @attempts.length
    if @guesses_left.zero?
      puts "You lost! You ran out of guesses. The code was #{
      Colors.to_list_string(Colors.code_to_array(@answer))
    }.".colorize({ mode: :bold })
    else
      puts "You have #{@max_guess_count - @attempts.length} guesses left.".colorize({ mode: :bold })
    end
  end

  def print_feedback(score)
    correct_count = score.count("B")
    almost_count = score.count("W")
    puts "✔ There #{to_v(correct_count)} #{correct_count} correct color#{to_s(correct_count)} in the correct spot."
      .colorize({ mode: :bold })
    puts "✘ There #{to_v(almost_count)} #{almost_count} correct color#{to_s(almost_count)} in an incorrect spot."
      .colorize({ mode: :bold })
    print_guesses_left
  end

  def to_v(number)
    number == 1 ? "is" : "are"
  end

  def to_s(number)
    number == 1 ? "" : "s"
  end

  def print_win
    puts "You guessed correctly! You took #{@attempts.length} guesses."
      .colorize({ mode: :bold })
  end
end
