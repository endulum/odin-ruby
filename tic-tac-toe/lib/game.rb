require "colorize"
require_relative "player"
require_relative "board"

# turn-based gameplay
class Game
  def initialize
    bold_print "Welcome to Tic-tac-toe\n\nWhat is Player 1's name?"
    @player_x = Player.new(read_input(:red), "x", :red)
    bold_print "#{@player_x.cname}'s mark will be \"#{@player_x.cmark}\".\n\nWhat is Player 2's name?"
    @player_o = Player.new(read_input(:blue), "o", :blue)
    bold_print "#{@player_o.cname}'s mark will be \"#{@player_o.cmark}\".\n\n"
    @current_turn = @player_x
    @board = Board.new
  end

  def play
    loop do
      @board.print_grid
      bold_print "It's #{@current_turn.cname}'s turn. Type an index number to place your mark on that spot."
      play_turn
      switch_turn
      break if check_winner || check_tie
    end
    return unless play_again

    @board = Board.new
    play
  end

  private

  # gameplay methods

  def switch_turn
    @current_turn = @current_turn == @player_o ? @player_x : @player_o
  end

  def play_turn
    was_valid_turn = @current_turn.play_turn(@board, read_grid_index_input) until was_valid_turn
  end

  def check_winner
    winner = if @player_o.winning?(@board)
               @player_o
             else
               @player_x.winning?(@board) ? @player_x : nil
             end
    @board.print_grid unless winner.nil?
    winner
  end

  def check_tie
    tie = @board.grid.none?(&:nil?)
    if tie
      bold_print("It's a tie! Nobody wins.")
      @board.print_grid
    end
    tie
  end

  def play_again
    bold_print("\nWant to play again, #{@player_o.cname} and #{@player_x.cname}?")
    bold_print "Type 'yes' to play again, type 'no' to quit."
    allowed_answers = %w[yes no]
    answer = read_input until allowed_answers.include?(answer)
    return false if answer == "no"

    true if answer == "yes"
  end

  # print methods

  def bold_print(string)
    puts string.colorize({ mode: :bold })
  end

  def read_input(color = :white)
    print "❯ ".colorize(color: color)
    gets.chomp
  end

  def warn_invalid_grid_index(input, color = :white)
    bold_print "#{input.colorize(color: color)} is not a valid grid index. Try again?" unless input.empty?
  end

  # input methods

  def read_grid_index_input
    input = read_input
    valid_grid_inputs = %w[0 1 2 3 4 5 6 7 8 9]
    until valid_grid_inputs.include?(input)
      warn_invalid_input(input, @current_turn.color)
      input = read_input
    end
    input.to_i
  end
end
