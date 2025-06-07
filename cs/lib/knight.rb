# Knight's Travails: find the shortest path a knight can take from square to square
module KnightsTravails
  extend self

  @diffs = [[-2, -1],
            [-1, -2],
            [2, 1],
            [1, 2],
            [-2, 1],
            [-1, 2],
            [2, -1],
            [1, -2]]

  def next_steps(square)
    next_steps = []
    @diffs.each do |x, y|
      x_diff = square[0] + x
      y_diff = square[1] + y
      next_steps.push([x_diff, y_diff]) if x_diff.between?(0, 7) && y_diff.between?(0, 7)
    end
    next_steps
  end

  def steps(start_square, end_square)
    nil
  end
end
