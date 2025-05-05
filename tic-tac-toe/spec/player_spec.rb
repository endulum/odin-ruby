require "spec_helper"
require "colorize"
require_relative "../lib/board"
require_relative "../lib/player"

describe "instantiation" do
  it "works" do
    Player.new("Player", "x", :red)
  end
end

describe "interaction with board" do
  board = Board.new
  expected_grid = ["x", "o", nil, nil, nil, nil, nil, nil, nil]
  bob = Player.new("Bob", "x", :red)
  alice = Player.new("Alice", "o", :blue)

  it "works" do
    bob.play_turn(board, 0)
    alice.play_turn(board, 1)
    expect(board.grid).to eq(expected_grid)
  end

  it "prohibits illegal moves" do
    bob.play_turn(board, 999)
    bob.play_turn(board, 1)
    expect(board.grid).to eq(expected_grid)
  end

  it "determines win" do
    expect(bob.winning?(board)).to be false
    bob.play_turn(board, 3)
    bob.play_turn(board, 6)
    expect(bob.winning?(board)).to be true
  end
end
