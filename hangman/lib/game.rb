require_relative "cli"
require_relative "dictionary"
require_relative "hangman"

# handles the gameloop
class Game
  def initialize
    Dictionary.check
    difficulty = prompt_difficulty until difficulty
    @hangman = Hangman.new(Dictionary.choose_word(difficulty))
  end

  def play
    loop do
      print_game
      guess = prompt_guess until guess
      word = @hangman.evaluate_guess(guess)
      if word
        CLI.bprint("The word was \"#{word}\"! You win!")
        break
      end
    end
  end

  def print_game
    CLI.bprint_all [
      "\nWord: #{@hangman.concealed_word}",
      "Incorrect letters: #{@hangman.incorrect_chars.join(', ')}",
      "Incorrect guesses: #{@hangman.incorrect_words.join(', ')}"
    ]
  end

  def prompt_difficulty
    input = CLI.read_input("Play easy, medium, or hard? (e/m/h)")
    accepted_inputs = %w[e m h]
    if accepted_inputs.include?(input)
      input
    else
      CLI.bprint "Invalid input: #{input}. Please type e for easy, m for medium, or h for hard."
      nil
    end
  end

  def prompt_guess
    input = CLI.read_input("Enter a letter, or guess the word")
    if input.length == 1
      handle_char_guess(input)
    else
      handle_word_guess(input)
    end
  end

  def handle_char_guess(char)
    if @hangman.char_already_guessed?(char)
      CLI.bprint "You already guessed this letter."
      nil
    else
      char
    end
  end

  def handle_word_guess(word)
    if @hangman.word_already_guessed?(word)
      CLI.bprint "You already guessed this word."
      nil
    else
      word
    end
  end
end
