require_relative "../guess/guess_scoring"

# based on "Beating Mastermind" RubyConf presentation
# https://www.youtube.com/watch?v=Okm_t5T1PiA

# "knowledge" of all possible guess, answer, and score combos
module ComputerBrain
  def self.init_all_answers
    colors = "12345".chars
    # each number corresponds to a color
    # we can represent combinations in just strings of these numbers

    @all_answers = colors.product(colors, colors, colors).map(&:join)
    # every possible combination of four colors
    # by "multiplying" the array four times by itself
  end

  def self.init_all_scores
    @all_scores = Hash.new { |h, k| h[k] = {} }
    # each guess corresponds to a hash and in that hash,
    # each answer corresponds to a score between that guess and this answer
    @all_answers
      .product(@all_answers)
      .each do |guess, answer|
        @all_scores[guess][answer] = GuessScoring.calculate(guess, answer)
      end
  end

  def self.copy_all
    possible_answers = @all_answers.dup
    possible_scores = @all_scores.dup
    [possible_answers, possible_scores]
  end

  def self.all_answers
    @all_answers
  end

  def self.all_scores
    @all_scores
  end

  puts "Initializing computer \"brain\", this should only happen once."
  init_all_answers
  init_all_scores
  @all_answers = @all_answers.to_set # sets have faster lookup
end
