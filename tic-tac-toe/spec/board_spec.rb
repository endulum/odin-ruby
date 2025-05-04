require "spec_helper"
require_relative "../lib/board"

describe "instantiation" do
  it "creates board" do
    board = Board.new
    expect(board.grid).to eq([nil, nil, nil, nil, nil, nil, nil, nil, nil])
  end
end

describe "mark placement" do
  it "places mark on valid empty area" do
    i = 0
    while i < 9 # for each possible index...
      board = Board.new
      # return true if successful place
      success = board.place("x", i)
      expect(success).to be true
      # construct expected grid and compare
      expected_grid = Array.new(9, nil)
      expected_grid[i] = "x"
      expect(board.grid).to eq(expected_grid)
      i += 1
    end
  end

  it "does not place a mark over a mark" do
    board = Board.new
    board.place("x", 0)
    success = board.place("o", 0)
    expect(success).to be false
    expect(board.grid).to eq(["x", nil, nil, nil, nil, nil, nil, nil, nil])
  end

  it "does not place a mark out of bounds" do
    board = Board.new
    success = board.place("x", 999)
    expect(success).to be false
    expect(board.grid).to eq([nil, nil, nil, nil, nil, nil, nil, nil, nil])
  end
end

describe "winning conditions" do
  it "does not register a win for an empty board" do
    board = Board.new
    expect(board.winning("x")).to be false
  end

  it "registers a vertical win" do
    board = Board.new
    [0, 3, 6].each { |index| board.place("x", index) }
    expect(board.winning("x")).to be true
  end

  it "registers a horizontal win" do
    board = Board.new
    [0, 1, 2].each { |index| board.place("x", index) }
    expect(board.winning("x")).to be true
  end

  it "registers a diagonal win" do
    board = Board.new
    [0, 4, 8].each { |index| board.place("x", index) }
    expect(board.winning("x")).to be true
  end
end

describe "print" do
  it "works" do
    board = Board.new
    board.place("x", 0)
    board.place("o", 8)
    board.print_grid
  end
end
