require "colorize"

# player with name, mark, and color choice, interacting with a board
class Player
  attr_reader :name, :mark, :color

  def initialize(name, mark, color)
    @name = name
    @mark = mark
    @color = color
  end

  def cname
    @name.colorize({ color: @color })
  end

  def cmark
    @mark.colorize({ color: @color })
  end

  def play_turn(board, index)
    if board.place(@mark, index, @color)
      puts "#{cname} placed a \"#{cmark}\" on index #{index}".colorize({ mode: :bold })
    else
      puts "Not a valid index. Try somewhere else?".colorize({ mode: :bold })
      false
    end
  end

  def winning?(board)
    won = board.winning?(@mark)
    puts "#{cname} won the game!".colorize({ mode: :bold }) if won
    won
  end
end
