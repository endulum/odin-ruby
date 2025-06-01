# numerical sequence where each number is the sum of the two numbers prior
module Fibonacci
  module_function

  def sequence_to(index)
    if index == 1
      return [0]
    elsif index == 2
      return [0, 1]
    else
      sequence = sequence_to(index - 1)
      sequence.push sequence[-2] + sequence[-1]
    end

    sequence
  end
end
