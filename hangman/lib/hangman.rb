# handles the word and stores guesses
class Hangman
  attr_reader :incorrect_words, :incorrect_chars, :correct_chars

  def initialize(word)
    @word = word
    @incorrect_words = []
    @incorrect_chars = []
    @correct_chars = []
  end

  def char_already_guessed?(char)
    @incorrect_chars.include?(char) || @correct_chars.include?(char)
  end

  def word_already_guessed?(word)
    @incorrect_words.include?(word)
  end

  def evaluate_guess(guess)
    return @word if @word == guess

    if guess.length > 1
      @incorrect_words.push(guess)
    elsif @word.chars.include?(guess)
      @correct_chars.push(guess)
      return @word if concealed_word.delete(" ") == @word
    else
      @incorrect_chars.push(guess)
    end
    nil
  end

  def concealed_word
    @word.chars.map do |char|
      @correct_chars.include?(char) ? char : "_"
    end.join(" ")
  end
end
