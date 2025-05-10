require "spec_helper"
require "colorize"
require_relative "../lib/colors"
require_relative "../lib/guess"

describe "parsing a guess" do
  it "returns guess if valid guess string" do
    expect(Guess.parse("red red red red")).to eq %w[red red red red]
  end

  it "returns nil if not enough colors" do
    expect(Guess.parse("red red red")).to be nil
  end

  it "returns nil if too many colors" do
    expect(Guess.parse("red red red red red")).to be nil
  end

  it "returns nil if unknown color" do
    expect(Guess.parse("red blue pink orange")).to be nil
  end

  it "random tests" do
    20.times do
      colors = Colors.sample
      expect(Guess.parse(colors.join(" "))).not_to be nil
    end
  end
end

describe "getting feedback from comparing guess to answer" do
  it "works (all correct)" do
    expect(
      Guess.compare(%w[red red red red], %w[red red red red])
    ).to eq %w[correct correct correct correct]
  end

  it "works (all almost)" do
    expect(
      Guess.compare(%w[red blue yellow green], %w[green yellow blue red])
    ).to eq %w[almost almost almost almost]
  end

  it "works (some correct, some almost)" do
    expect(
      Guess.compare(%w[red blue red blue], %w[red blue blue red])
    ).to eq %w[correct correct almost almost]
  end

  it "works (nothing)" do
    expect(
      Guess.compare(%w[red red red red], %w[blue blue blue blue])
    ).to eq []
  end
end
