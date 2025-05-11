# handle scoring
module Scoring
  def self.calculate(code, answer)
    @score = ""
    @wrong_guess_colors = []
    @wrong_answer_colors = []
    @pairs = code.chars.zip(answer.chars)
    calculate_black_pegs
    calculate_white_pegs
    @score
  end

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
end
