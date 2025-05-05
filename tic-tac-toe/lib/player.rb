require "colorize"

# player with name, mark, and color choice, interacting with a board
class Player
  attr_reader :name, :mark, :color

  def initialize(name, mark, color)
    @name = name
    @mark = mark
    @color = color
  end

  def play_turn(board, index)
    if board.place(@mark, index, @color)
      puts "#{
        @name.colorize({ color: @color })
      } placed a \"#{
        @mark.colorize({ color: @color })
      }\" on index #{index}".colorize({ mode: :bold })
    else
      puts "Not a valid index. Try somewhere else?".colorize({ mode: :bold })
      false
    end
  end

  def winning?(board)
    won = board.winning?(@mark)
    if won
      puts "#{
          @name.colorize({ color: @color })
        } won the game!".colorize({ mode: :bold })
    end
    won
  end
end
