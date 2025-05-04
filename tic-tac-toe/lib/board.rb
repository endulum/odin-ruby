# grid of spaces for marks
class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(9, nil)
  end

  def place(mark, index)
    return false unless index.to_i < @grid.size
    return false unless @grid[index].nil?

    @grid[index] = mark
    true
  end

  def winning(mark)
    [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], # row wins
      [0, 3, 6], [1, 4, 7], [2, 5, 8], # column wins
      [0, 4, 8], [2, 4, 6] # diagonal wins
    ].any? do |combo|
      Array.new(3, mark) == [@grid[combo[0]], @grid[combo[1]], @grid[combo[2]]]
    end
  end
end
