require "spec_helper"
require "colorize"
require_relative "../lib/colors"

all_colors = %w[red blue green yellow magenta]
wrong_colors = %w[pink orange purple white black]

describe "showing all colors" do
  it "shows array of valid colors" do
    expect(Colors.all).to eq all_colors
  end

  it "shows a colorized string of all valid colors" do
    expect(Colors.all_to_list_string).to eq(
      "#{
        'red'.colorize({ color: :red })
      }, #{
        'blue'.colorize({ color: :blue })
      }, #{
        'green'.colorize({ color: :green })
      }, #{
        'yellow'.colorize({ color: :yellow })
      }, and #{
        'magenta'.colorize({ color: :magenta })
      }"
    )
  end
end

describe "color string conversion" do
  it "returns a symbol for each color, if a valid color" do
    all_colors.each do |color|
      expect(Colors.to_symbol(color)).to be_a(Symbol)
    end
    wrong_colors.each do |color|
      expect(Colors.to_symbol(color)).to be_nil
    end
  end

  it "returns a colorized string for each color, if a valid color" do
    all_colors.each do |color|
      expect(
        Colors.to_string(color)
      ).to eq(
        color.colorize({ color: Colors.to_symbol(color) })
      )
    end
    wrong_colors.each do |color|
      expect(Colors.to_string(color)).to be_nil
    end
  end
end

describe "predicates" do
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
      Colors.array_of_colors?(%w[red pink white])
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
