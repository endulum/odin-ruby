require_relative "lib/loops/computer_loop"
require_relative "lib/loops/human_loop"

game = ComputerLoop.new

loop do
  game.play
end
