require_relative "spec_helper"
require_relative "../lib/dictionary"

describe "dictionary module" do
  it "downloads dictionary" do
    # if data/dictionary.txt exists, delete it so we can test download
    if File.exist?("data/dictionary.txt")
      File.open("data/dictionary.txt") do |f|
        File.delete(f)
      end
    end

    Dictionary.check
    expect(Dictionary.words).not_to be nil
    expect(Dictionary.words.all? { |w| w.length.between?(5, 12) }).to be true
  end

  it "picks a random word given a difficulty rating" do
    10.times do
      word = Dictionary.choose_word("e")
      expect(word.length < 7).to be true
    end

    10.times do
      word = Dictionary.choose_word("m")
      expect(word.length.between?(7, 9)).to be true
    end

    10.times do
      word = Dictionary.choose_word("h")
      expect(word.length > 9).to be true
    end
  end
end
