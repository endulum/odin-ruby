require "colorize"
require_relative "colors"
require_relative "cli"
require_relative "guess"
require_relative "guesstable"

# creates and controls the game loop
class Gameloop
  include GuessTable

  def initialize
    @answer = Colors.sample
    @attempts = []
  end

  def play
    print_start
    loop do
      attempt = make_attempt
      if attempt.guess == @answer
        print_win
        break
      else
        print_feedback(attempt.feedback)
      end
    end
  end

  private

  def make_attempt
    attempt = Guess.new(@answer)
    print_guess(attempt.guess)
    @attempts.push attempt
    print_table(@attempts)
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

  def print_guess(guess)
    puts "You guessed: #{guess.map do |c|
      Colors.to_string(c)
    end.join(', ')}".colorize({ mode: :bold })
  end

  def print_feedback(feedback)
    correct_count = feedback.count("correct")
    almost_count = feedback.count("almost")
    puts "You have #{correct_count} correct color#{
      correct_count == 1 ? '' : 's'
    } in the correct spot.".colorize({ mode: :bold })
    puts "You have #{almost_count} correct color#{
      almost_count == 1 ? '' : 's'
    } in an incorrect spot.".colorize({ mode: :bold })
  end

  def print_win
    puts "You guessed correctly! The code was #{@answer.map do |c|
      Colors.to_string(c)
    end.join(', ')}. You took #{@attempts.length} guesses."
       .colorize({ mode: :bold })
  end
end
