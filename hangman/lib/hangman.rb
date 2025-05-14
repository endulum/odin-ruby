require "pry-byebug"
require_relative "cli"
require_relative "dictionary"

# gameplay, guess management
class Game
  def initialize
    Dictionary.check
  end

  def init_for_game
    difficulty = prompt_difficulty until difficulty
    @word = Dictionary.choose_word(difficulty)
    @incorrect_chars = []
    @incorrect_words = []
    @correct_chars = []
  end

  def play
    init_for_game
    loop do
      render_word
      guess = prompt_guess until guess
      break if correct_guess?(guess)
    end
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
    if char_already_guessed?(char)
      CLI.bprint "You already guessed this letter."
      nil
    else
      char
    end
  end

  def handle_word_guess(word)
    if word_already_guessed?(word)
      CLI.bprint "You already guessed this word."
      nil
    else
      word
    end
  end

  def render_word
    word_to_render = @word.chars.map do |char|
      if @correct_chars.include?(char)
        char
      else
        "_"
      end
    end
    CLI.bprint(word_to_render.join(" "))
  end

  def correct_guess?(guess)
    if @word == guess
      CLI.bprint "The word is '#{guess}'! You win."
      return true
    elsif guess.length > 1
      CLI.bprint "The word is not '#{guess}'!"
      add_incorrect_word(guess)
    elsif @word.chars.include?(guess)
      CLI.bprint "'#{guess}' exists in this word!"
      add_correct_char(guess)
    else
      CLI.bprint "'#{guess}' does not exist in this word!"
      add_correct_char(guess)
    end
    false
  end

  def char_already_guessed?(char)
    @incorrect_chars.include?(char) || @correct_chars.include?(char)
  end

  def word_already_guessed?(word)
    @incorrect_words.include?(word)
  end

  def add_incorrect_char(char)
    @incorrect_chars.push(char) unless @incorrect_chars.include?(char)
  end

  def add_incorrect_word(word)
    @incorrect_words.push(word) unless @incorrect_words.include?(word)
  end

  def add_correct_char(char)
    @correct_chars.push(char) unless @correct_chars.include?(char)
  end
end
