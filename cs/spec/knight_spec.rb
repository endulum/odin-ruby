require_relative "../lib/knight"

describe "knight's paths" do
  it "finds next steps for a knight" do
    next_steps = [[2, 5], [5, 2], [1, 4], [4, 1], [4, 5], [5, 4], [2, 1], [1, 2]]
    expect(KnightsTravails.next_steps([3, 3])).to match_array next_steps
  end

  it "skips out-of-bounds steps" do
    next_steps = [[3, 7], [3, 5], [2, 4], [0, 4]]
    expect(KnightsTravails.next_steps([1, 6])).to match_array next_steps
  end
end

describe "knight's travails" do
  it "works with one step" do
    expect(KnightsTravails.steps([0, 0], [1, 2])).to eq [[0, 0], [1, 2]]
  end

  it "works with multiple steps" do
    expect(KnightsTravails.steps([0, 0], [3, 3])).to satisfy do |value|
      [[[0, 0], [2, 1], [3, 3]], [[0, 0], [1, 2], [3, 3]]].include?(value)
    end
    expect(KnightsTravails.steps([3, 3], [0, 0])).to satisfy do |value|
      [[[3, 3], [2, 1], [0, 0]], [[3, 3], [1, 2], [0, 0]]].include?(value)
    end
    expect(KnightsTravails.steps([0, 0], [7, 7])).to satisfy do |value|
      [[[0, 0], [2, 1], [4, 2], [6, 3], [4, 4], [6, 5], [7, 7]],
       [[0, 0], [2, 1], [4, 2], [6, 3], [7, 5], [5, 6], [7, 7]]].include?(value)
    end
  end
end
