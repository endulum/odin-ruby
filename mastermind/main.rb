require_relative "lib/gameplay"
require_relative "lib/cli"

def print_instructions
  CLI.print_bold_all(
    [
      "To make a guess, enter the names of the four colors of your guess.",
      "The available colors are #{Colors.all_to_colorized_string}.",
      "Proper format is each color separated by space, e.g. 'red blue red blue'."
    ]
  )
end

print_instructions

game = Gameplay.new
game.play
