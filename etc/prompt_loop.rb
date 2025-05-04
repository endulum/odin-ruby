require "colorize"

# looping prompt for user input
class PromptLoop
  def initialize(
    color,
    command_to_break,
    command_reader,
    print_start,
    print_end
  )
    @color = color
    @command_to_break = command_to_break
    @command_reader = command_reader # function to handle arbitrary valid commands
    @print_start = print_start # function to print at start of loop
    @print_end = print_end # function to print at exit of loop
  end

  def start
    @print_start.call(@color)
    loop do
      command = read_command
      if command == @command_to_break
        @print_end.call(@color)
        break
      end
      is_valid_command = @command_reader.call(command)
      warn_invalid_command(command) unless is_valid_command
    end
  end

  private

  def read_command
    print "❯ ".colorize(color: @color)
    gets.chomp
  end

  def warn_invalid_command(command)
    puts "#{
      command.colorize(color: @color)
    } is not a valid command, try again?".colorize(mode: :bold)
  end
end

def start_msg(color)
  puts "Welcome to this loop".colorize({ color: color, mode: :bold })
  puts "Enter #{
    'exit'.colorize({ color: color })
  } to exit this loop".colorize({ mode: :bold })
  puts "Enter #{
    'new'.colorize({ color: color })
  } to enter a new loop".colorize({ mode: :bold })
end

def end_msg(color)
  puts "Goodbye".colorize({ color: color, mode: :bold })
end

def handle_command(command)
  if command == "new"
    game_loop = PromptLoop.new(
      String.colors.sample, "exit",
      method(:handle_command), method(:start_msg), method(:end_msg)
    )
    game_loop.start
    true
  else
    false
  end
end

program_loop = PromptLoop.new(
  String.colors.sample, "exit",
  method(:handle_command), method(:start_msg), method(:end_msg)
)
program_loop.start
