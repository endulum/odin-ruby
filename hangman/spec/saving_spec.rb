require "fileutils"
require_relative "spec_helper"
require_relative "../lib/saving"
require_relative "../lib/hangman"

SDIR = "data/saves".freeze

# empty existing save dir
FileUtils.rm_rf("#{SDIR}/.", secure: true)

# create some hangman games
hangman_games = [
  {
    word: "lackadasical",
    guesses: %w[a c l x y z whimsical]
  },
  {
    word: "predominant",
    guesses: %w[d o m]
  },
  {
    word: "apparition",
    guesses: %w[x y z]
  }
].map do |game|
  hangman = Hangman.new(game[:word])
  game[:guesses].each { |g| hangman.evaluate_guess(g) }
  hangman
end

describe "save file management" do
  it "writes mpack to save files" do
    hangman_games.each do |game|
      Saving.save(game)
    end
    expect(Dir.children(SDIR).length).to eq hangman_games.length
  end

  it "displays saves as a list with correct concealed string" do
    # intended output:
    # [1] May 16, 2025, 21:57 : "l a c _ a _ a _ _ c a l"
    # [2] May 16, 2025, 21:57 : "_ _ _ _ _ _ _ _ _ _"
    # [3] May 16, 2025, 21:57 : "_ _ _ d o m _ _ _ _ _"

    entries = Saving.show_save_entries
    entries.each do |entry|
      has_correct_concealed_string = hangman_games.one? do |game|
        game.concealed_word == entry.match(/"([^"]*)"/)[1]
      end
      expect(has_correct_concealed_string).to be true
    end
  end

  it "loads a game based on index selection" do
    target_entry = Saving.show_save_entries[0]
    expect(target_entry.start_with?("[1]")).to be true
    loaded_game = Saving.load_by_index(1)
    expect(loaded_game.concealed_word).to eq target_entry.match(/"([^"]*)"/)[1]
  end
end
