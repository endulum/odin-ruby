require "spec_helper"
require "colorize"
require_relative "../lib/colors"
require_relative "../lib/guess/guess_input"

describe "parsing a guess" do
  it "returns guess if valid guess string" do
    expect(GuessInput.parse("red red red red")).to eq "1111"
  end

  it "returns nil if not enough colors" do
    expect(GuessInput.parse("red red red")).to be nil
  end

  it "returns nil if too many colors" do
    expect(GuessInput.parse("red red red red red")).to be nil
  end

  it "returns nil if unknown color" do
    expect(GuessInput.parse("red blue pink orange")).to be nil
  end

  it "random tests" do
    20.times do
      colors = Colors.sample
      expect(GuessInput.parse(colors.join(" "))).not_to be nil
    end
  end
end
