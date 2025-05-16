require_relative "cli"
require_relative "dictionary"
require_relative "hangman"

# handles the gameloop
class Game
  def initialize(hangman = nil)
    Dictionary.check
    difficulty = prompt_difficulty until difficulty
    @hangman = if hangman.nil?
                 Hangman.new(Dictionary.choose_word(difficulty))
               else
                 hangman
               end
  end

  def play
    loop do
      print_game
      guess = prompt_guess until guess
      result = @hangman.evaluate_guess(guess)
      break if end_of_game?(result)
    end
  end

  def print_game
    CLI.bprint_all [
      "\nWord: #{@hangman.concealed_word}",
      "Incorrect letters: #{@hangman.incorrect_chars.join(', ')}",
      "Incorrect guesses: #{@hangman.incorrect_words.join(', ')}"
    ]
  end

  def end_of_game?(result)
    if result
      return print_guess_win(result)
    elsif @hangman.concealed_word.delete(" ").count("_").zero?
      return print_reveal_win(@hangman.concealed_word.delete(" "))
    elsif @hangman.incorrect_chars.length + @hangman.incorrect_words.length == 6
      return print_guess_lose
    end

    false
  end

  def print_guess_win(result)
    CLI.bprint("\nThe word was #{result}! You won!")
    true
  end

  def print_reveal_win(result)
    print_game
    CLI.bprint("\nYou revealed the word, which was \"#{result}\"! You won!")
    true
  end

  def print_guess_lose
    print_game
    CLI.bprint("\nYou ran out of guesses! You lost!")
    true
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
    if input == "save"
      handle_save
    elsif input.length == 1
      handle_char_guess(input)
    elsif input.length > 1
      handle_word_guess(input)
    else
      false
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

  def handle_save
    p @hangman.to_mpack
    nil
  end
end
