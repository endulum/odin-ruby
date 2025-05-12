require "colorize"

# handle scoring for a guess
module GuessScoring
  def self.calculate(code, answer)
    @score = ""
    @wrong_guess_colors = []
    @wrong_answer_colors = []
    @pairs = code.chars.zip(answer.chars)
    calculate_black_pegs
    calculate_white_pegs
    print_feedback(@score) unless defined?(RSpec)
    @score
  end

  def self.print_feedback(score)
    correct_count = score.count("B")
    almost_count = score.count("W")
    puts "✔ There #{to_v(correct_count)} #{correct_count} correct color#{to_s(correct_count)} in the correct spot."
      .colorize({ mode: :bold })
    puts "✘ There #{to_v(almost_count)} #{almost_count} correct color#{to_s(almost_count)} in an incorrect spot."
      .colorize({ mode: :bold })
  end

  # TODO: make below private

  def self.calculate_black_pegs
    @pairs.each do |guess, answer| # ?
      if guess == answer
        @score << "B"
      else
        @wrong_guess_colors << guess
        @wrong_answer_colors << answer
      end
    end
  end

  def self.calculate_white_pegs
    @wrong_guess_colors.each do |color|
      if @wrong_answer_colors.include?(color)
        @wrong_answer_colors.delete(color)
        @score << "W"
      end
    end
  end

  def self.to_v(number)
    number == 1 ? "is" : "are"
  end

  def self.to_s(number)
    number == 1 ? "" : "s"
  end
end
