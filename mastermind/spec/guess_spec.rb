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

describe("simulate gameplay (1)") do
  it "works" do
    answer = %w[yellow red yellow blue]
    history = [
      { guess: %w[red red red red], feedback: %w[correct] },
      { guess: %w[red yellow yellow yellow], feedback: %w[correct almost almost] },
      { guess: %w[yellow red yellow yellow], feedback: %w[correct correct correct] },
      { guess: %w[yellow red yellow blue], feedback: %w[correct correct correct correct] }
    ]
    history.each do |round|
      expect(
        Guess.compare(round[:guess], answer)
      ).to eq round[:feedback]
    end
  end
end

describe("simulate gameplay (2)") do
  it "works" do
    answer = %w[green blue blue yellow]
    history = [
      { guess: %w[red red red red], feedback: [] },
      { guess: %w[yellow yellow yellow yellow], feedback: %w[correct] },
      { guess: %w[yellow blue blue blue], feedback: %w[correct correct almost] },
      { guess: %w[blue yellow blue blue], feedback: %w[correct almost almost] },
      { guess: %w[blue blue yellow blue], feedback: %w[correct almost almost] },
      { guess: %w[blue blue blue yellow], feedback: %w[correct correct correct] },
      { guess: %w[green blue blue yellow], feedback: %w[correct correct correct correct] }
    ]
    history.each do |round|
      expect(
        Guess.compare(round[:guess], answer)
      ).to eq round[:feedback]
    end
  end
end
