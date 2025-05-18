# require_relative "lib/game"
# require_relative "lib/cli"
# require_relative "lib/saving"

# def prompt_yes_or_no
#   input = CLI.read_input
#   accepted_inputs = %w[y n]
#   if accepted_inputs.include?(input)
#     input
#   else
#     CLI.bprint "Not a valid input: #{input}. Type \"y\" for yes or \"n\" for no."
#     nil
#   end
# end

# def prompt_save_selection(entries)
#   input = CLI.read_input.to_i
#   accepted_inputs = (0..entries.length - 1).to_a.map { |e| e + 1 }
#   if accepted_inputs.include?(input)
#     input
#   else
#     CLI.bprint "Not a valid input: #{input}. Please choose a number #{accepted_inputs}."
#     nil
#   end
# end

# def select_save(entries)
#   entries.each { |entry| puts entry }
#   CLI.bprint "Type the number next to the saved game to select that game to load."
#   selection = prompt_save_selection(entries) until selection
#   CLI.bprint "Loading selection..."
#   Saving.load_by_index(selection)
# end

# def check_entries_for_game
#   entries = Saving.show_save_entries
#   return nil if entries.empty?

#   CLI.bprint "There are #{entries.length} saved games found. Would you like to view these saves? (y/n)"
#   answer = prompt_yes_or_no until answer
#   if answer == "y"
#     saved_hangman = select_save(entries)
#     return saved_hangman
#   end

#   nil
# end

# loop do
#   game = Game.new(check_entries_for_game)
#   game.play

#   CLI.bprint "Would you like to play again? (y/n)"
#   play_again = prompt_yes_or_no until play_again
#   if play_again == "n"
#     CLI.bprint "Goodbye"
#     break
#   end
# end

# def valid_command?(str)
#   !!(str =~ /^(save|delete) [1-4]$/)
# end

# puts valid_command?("save 2")    # => true
# puts valid_command?("delete 3")  # => true
# puts valid_command?("avocado")   # => false
# puts valid_command?("9")         # => false
# puts valid_command?("save 7")    # => false
# puts valid_command?("delete2")   # => false

require_relative "lib/loop"

Loop.play
