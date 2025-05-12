require "spec_helper"
require_relative "../lib/scoring"

describe "scoring" do
  it "works (all correct)" do
    expect(Scoring.calculate("1111", "1111")).to eq "BBBB"
  end

  it "works (all almost)" do
    expect(Scoring.calculate("4321", "1234")).to eq "WWWW"
  end

  it "works (some correct)" do
    expect(Scoring.calculate("1221", "1234")).to eq "BB"
  end

  it "works (some almost)" do
    expect(Scoring.calculate("1212", "3321")).to eq "WW"
  end

  it "works (some correct, some almost)" do
    expect(Scoring.calculate("1212", "1221")).to eq "BBWW"
  end

  it "works (nothing)" do
    expect(Scoring.calculate("1111", "2222")).to eq ""
  end
end

describe("simulate gameplay (1)") do
  it "works" do
    answer = "3132"
    history = [
      { guess: "1111", score: "B" },
      { guess: "1333", score: "BWW" },
      { guess: "3133", score: "BBB" },
      { guess: "3132", score: "BBBB" }
    ]
    history.each do |round|
      expect(Scoring.calculate(round[:guess], answer)).to eq round[:score]
    end
  end
end

describe("simulate gameplay (2)") do
  it "works" do
    answer = "4223"
    history = [
      { guess: "1111", score: "" },
      { guess: "3333", score: "B" },
      { guess: "3222", score: "BBW" },
      { guess: "2322", score: "BWW" },
      { guess: "2232", score: "BWW" },
      { guess: "2223", score: "BBB" },
      { guess: "4223", score: "BBBB" }
    ]
    history.each do |round|
      expect(Scoring.calculate(round[:guess], answer)).to eq round[:score]
    end
  end
end
