require_relative "cli"
require_relative "saving"
require_relative "game"

# the program loop
module Loop
  def self.play
    print_welcome
    loop do
      check_save_entries
      @game = Game.new(@hangman)
      @game.play
      if prompt_continue == "n"
        CLI.bprint "Goodbye"
        break
      end
    end
  end

  def self.print_welcome
    CLI.bprint "Welcome to Hangman"
  end

  def self.check_save_entries
    @entries = Saving.show_save_entries
    return if @entries.empty?

    CLI.bprint "There are #{@entries.length} saved games found. Would you like to view these saves? (y/n)"
    answer = CLI.prompt_answer
    show_save_entries if answer == "y"
  end

  def self.show_save_entries
    puts
    @entries.each { |entry| puts entry }
    puts
    print_save_options
    command, index = prompt_save_selection
    if command == "delete"
      delete_save(index.to_i)
    elsif command == "load"
      load_save(index.to_i)
    end
  end

  def self.print_save_options
    CLI.bprint_all [
      "Type \"load <number>\" to load the saved game indicated by  [<number>].",
      "Type \"delete <number>\" to delete the saved game indicated by [<number>].",
      "Type \"back\" to exit the entry view and start a new game."
    ]
  end

  def self.prompt_save_selection
    loop do
      input = CLI.read_input
      return input.split if valid_save_selection?(input)

      CLI.bprint_all [
        "Invalid input: #{input}",
        "Check that you spelled your command correctly and/or that the index you typed exists."
      ]
    end
  end

  def self.valid_save_selection?(selection)
    valid_save_indices = "(#{(1..@entries.length).to_a.join('|')})"
    regex = /^(back|(load|delete) #{valid_save_indices})$/
    regex.match?(selection)
  end

  def self.delete_save(index)
    Saving.delete_by_index(index)
    CLI.bprint "Save deleted successfully."
    @entries = Saving.show_save_entries
    if @entries.empty?
      CLI.bprint "No save entries left. Exiting."
      return
    end

    show_save_entries
  end

  def self.load_save(index)
    @hangman = Saving.load_by_index(index)
  end

  def self.prompt_continue
    CLI.bprint "Play again? (y/n)"
    CLI.prompt_answer
  end
end
