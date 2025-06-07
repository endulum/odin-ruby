require_relative "../lib/knight"

describe "knight's travails" do
  it "works with one step" do
    expect(KnightsTravails.knight_moves([0, 0], [1, 2])).to eq [[0, 0], [1, 2]]
  end

  it "works with multiple steps" do
    expect(KnightsTravails.knight_moves([0, 0], [3, 3])).to satisfy do |value|
      [[[0, 0], [2, 1], [3, 3]], [[0, 0], [1, 2], [3, 3]]].include?(value)
    end
    expect(KnightsTravails.knight_moves([3, 3], [0, 0])).to satisfy do |value|
      [[[3, 3], [2, 1], [0, 0]], [[3, 3], [1, 2], [0, 0]]].include?(value)
    end
    expect(KnightsTravails.knight_moves([0, 0], [7, 7])).to satisfy do |value|
      [[[0, 0], [2, 1], [4, 2], [6, 3], [4, 4], [6, 5], [7, 7]],
       [[0, 0], [2, 1], [4, 2], [6, 3], [7, 5], [5, 6], [7, 7]]].include?(value)
    end
  end
end
