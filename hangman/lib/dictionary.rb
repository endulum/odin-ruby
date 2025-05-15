require "open-uri"
require_relative "cli"

# words to be used in game
module Dictionary
  DICTIONARY_URL = "https://raw.githubusercontent.com/first20hours/google-10000-english/master/google-10000-english-no-swears.txt".freeze

  def self.check
    if @words&.length&.positive?
      CLI.bprint "Dictionary already loaded."
    elsif File.exist? "./data/dictionary.txt"
      CLI.bprint "Dictionary file exists."
      load
    else
      CLI.bprint "Dictionary file does not exist."
      download
    end
  end

  def self.load
    CLI.bprint "Loading dictionary..."
    File.open("./data/dictionary.txt") do |f|
      @words = f.readlines.map(&:chomp)
    end
  end

  def self.download
    CLI.bprint "Downloading dictionary..."
    dictionary_download = URI.parse(DICTIONARY_URL).open
    @words = File
             .read(dictionary_download)
             .split("\n")
             .keep_if { |word| word.length.between?(5, 12) }
    File.new("./data/dictionary.txt", "w+")
    File.open("./data/dictionary.txt", "w+") do |f|
      f.puts(@words)
    end
  end

  def self.words
    @words
  end

  def self.choose_word(difficulty)
    case difficulty
    when "e"
      @words.filter { |word| word.length < 7 }.sample
    when "m"
      @words.filter { |word| word.length.between?(7, 9) }.sample
    when "h"
      @words.filter { |word| word.length > 9 }.sample
    end
  end
end
