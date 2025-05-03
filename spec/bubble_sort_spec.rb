require "spec_helper"
require_relative "../lib/basics/bubble_sort"

describe "bubble sort" do
  it "works" do
    expect(bubble_sort([4, 3, 78, 2, 0, 2])).to eq([0, 2, 2, 3, 4, 78])
  end

  it "works" do
    expect(bubble_sort([3, 2, 9, 6, 5])).to eq([2, 3, 5, 6, 9])
  end

  it "works" do
    expect(bubble_sort([9, 8, 7, 6, 5, 4, 3, 2, 1, 0])).to eq([0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
  end
end
