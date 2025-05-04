require "colorize"

# grid of spaces for marks
class Board
  def initialize
    @grid = Array.new(9, nil)
  end

  def grid
    @grid.map { |cell| cell ? cell[:mark] : nil }
  end

  def place(mark, index, color = :white)
    return false unless index.to_i < @grid.size
    return false unless @grid[index].nil?

    @grid[index] = { mark: mark, color: color }
    true
  end

  def winning(mark)
    [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], # row wins
      [0, 3, 6], [1, 4, 7], [2, 5, 8], # column wins
      [0, 4, 8], [2, 4, 6] # diagonal wins
    ].any? do |combo|
      combo.map do |index|
        @grid[index] ? @grid[index][:mark] : nil
      end == [mark, mark, mark]
    end
  end

  def print_grid
    print "╔═══╦═══╦═══╗\n".colorize({ color: :gray })
    @grid.each_with_index do |cell, index|
      print_cell(cell, index)
      print "║\n".colorize({ color: :gray }) if ((index + 1) % 3).zero?
      print "╠═══╬═══╬═══╣\n".colorize({ color: :gray }) if ((index + 1) % 3).zero? && index < 8
    end
    print "╚═══╩═══╩═══╝\n".colorize({ color: :gray })
  end

  private

  def print_cell(cell, index)
    print "║ ".colorize({ color: :gray })
    if cell
      print "#{cell[:mark].colorize({ color: cell[:color], mode: :bold })} "
    else
      print "#{index.to_s.colorize({ color: :gray })} "
    end
  end
end
