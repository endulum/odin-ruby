require "open-uri"
require_relative "cli"

# words to be used in game
module Dictionary
  DICTIONARY_URL = "https://raw.githubusercontent.com/first20hours/google-10000-english/master/google-10000-english-no-swears.txt".freeze

  def self.check
    if File.exist? "./data/dictionary.txt"
      CLI.bprint "Dictionary exists."
    else
      CLI.bprint "Dictionary does not exist."
      download
    end
  end

  def self.download
    CLI.bprint "Downloading dictionary..."
    dictionary_download = URI.parse(DICTIONARY_URL).open
    words = File
            .read(dictionary_download)
            .split("\n")
            .keep_if { |word| word.length.between?(5, 12) }
    File.new("./data/dictionary.txt", "w+")
    File.open("./data/dictionary.txt", "w+") do |f|
      f.puts(words)
    end
  end
end
