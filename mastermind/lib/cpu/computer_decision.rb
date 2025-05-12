require_relative "computer_brain"

# uses knowledge of possible guess-answer-score combos to determine best guesses
class ComputerDecision
  def initialize
    possible_answers, possible_scores = ComputerBrain.copy_all
    @possible_answers = possible_answers
    @possible_scores = possible_scores
  end

  def make_guess(last_attempt)
    if last_attempt
      reduce_possible_answers(last_attempt)
      minmax_guess
    else
      "1122"
    end
  end

  def reduce_possible_answers(last_attempt)
    @possible_answers.keep_if do |answer|
      ComputerBrain.all_scores[last_attempt.guess][answer] == last_attempt.score
    end
  end

  def minmax_guess
    guesses = @possible_scores.map do |guess, scores_by_answer|
      scores_by_answer = scores_by_answer.select do |answer, _score|
        @possible_answers.include?(answer)
      end
      @possible_scores[guess] = scores_by_answer
      score_groups = scores_by_answer.values.group_by(&:itself)
      possibility_counts = score_groups.values.map(&:length)
      worst_case_possibilities = possibility_counts.max
      impossible_guess = @possible_answers.include?(guess) ? 0 : 1
      [worst_case_possibilities, impossible_guess, guess]
    end
    guesses.min.last
  end
end
