require "spec_helper"
require "colorize"
require_relative "../lib/colors"

all_colors = %w[red blue green yellow magenta]

describe "all valid colors" do
  it "shows array of all valid colors" do
    expect(Colors.all).to eq all_colors
  end
end

describe "Colorizer helpers" do
  it "gets a colorized string of colors given an array of names" do
    expect(Colors.to_list_string(%w[red blue yellow]))
      .to eq "#{
        'red'.colorize({ color: :red })}, #{
        'blue'.colorize({ color: :blue })}, #{
        'yellow'.colorize({ color: :yellow })}"
  end

  it "gets a colorized string of all valid colors" do
    expect(Colors.all_to_list_string).to eq(
      "#{'red'.colorize({ color: :red })}, #{
         'blue'.colorize({ color: :blue })}, #{
         'green'.colorize({ color: :green })}, #{
         'yellow'.colorize({ color: :yellow })}, and #{
         'magenta'.colorize({ color: :magenta })}"
    )
  end
end

describe "conversions" do
  it "converts code to colors" do
    expect(Colors.code_to_array("12345")).to eq all_colors
  end

  it "converts colors to code" do
    expect(Colors.array_to_code(all_colors)).to eq "12345"
  end
end

describe "predicates" do
  wrong_colors = %w[pink orange purple white black]

  it "determines individual valid colors" do
    all_colors.each do |color|
      expect(Colors.color?(color)).to be true
    end
    wrong_colors.each do |color|
      expect(Colors.color?(color)).to be false
    end
  end

  it "determines if string array is all valid colors" do
    expect(
      Colors.array_of_colors?(%w[red blue])
    ).to be true
    expect(
      Colors.array_of_colors?(%w[owo uwu])
    ).to be false
    expect(
      Colors.array_of_colors?(all_colors + wrong_colors)
    ).to be false
  end
end

describe "sampling" do
  it "returns array of four randomly-picked colors" do
    10.times do
      picked_colors = Colors.sample
      expect(picked_colors.all? do |color|
        Colors.color?(color)
      end)
    end
  end
end
