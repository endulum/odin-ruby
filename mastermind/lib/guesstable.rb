require "colorize"
require_relative "colors"

# printing the table of attempts
module GuessTable
  def print_table(attempts)
    puts top
    attempts.each_with_index do |attempt, index|
      print row_count(index)
      print row_guess(attempt.guess)
      print row_feedback(attempt.feedback)
    end
    puts bottom
  end

  private

  def top
    "   ╔═ ".colorize(
      { color: :gray }
    ) + "Guesses".colorize(
      { color: :white, mode: :bold }
    ) + " ═╦═══════════╗".colorize(
      { color: :gray }
    )
  end

  def row_count(index)
    (index + 1).to_s.rjust(2, " ").colorize(
      { color: :white, mode: :bold }
    ) + " ║  ".colorize({ color: :gray })
  end

  def row_guess(guess)
    guess.map do |color|
      "●".colorize({ color: Colors.to_symbol(color) })
    end.join(" ") + "  ║  ".colorize({ color: :gray })
  end

  def row_feedback(feedback)
    feedback
      .join(" ")
      .gsub("correct", "✔")
      .gsub("almost", "✘")
      .ljust(7, " ")
      .colorize({ color: :white }) + "  ║\n".colorize({ color: :gray })
  end

  def bottom
    "   ╚═══════════╩═══════════╝".colorize({ color: :gray })
  end
end
