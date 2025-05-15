require_relative "spec_helper"
require_relative "../lib/hangman"

describe "revealing the word only at a correct guess" do
  hangman = Hangman.new("bear")
  it "handles a wrong char" do
    word = hangman.evaluate_guess("w")
    expect(word).to be nil
    expect(hangman.incorrect_chars).to eq ["w"]
  end

  it "handles a correct char" do
    word = hangman.evaluate_guess("b")
    expect(word).to be nil
    expect(hangman.correct_chars).to eq ["b"]
  end

  it "handles a wrong word" do
    word = hangman.evaluate_guess("boar")
    expect(word).to be nil
    expect(hangman.incorrect_words).to eq ["boar"]
  end

  it "handles a correct word" do
    word = hangman.evaluate_guess("bear")
    expect(word).to eq "bear"
  end
end

describe "concealed word" do
  hangman = Hangman.new("lackadasical")

  it "works" do
    hangman.evaluate_guess("a")
    expect(hangman.concealed_word).to eq "_ a _ _ a _ a _ _ _ a _"
    hangman.evaluate_guess("c")
    expect(hangman.concealed_word).to eq "_ a c _ a _ a _ _ c a _"
    hangman.evaluate_guess("l")
    expect(hangman.concealed_word).to eq "l a c _ a _ a _ _ c a l"
  end
end
