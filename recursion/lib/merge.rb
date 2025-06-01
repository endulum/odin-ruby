# the classic "divide and conquer" sorting algorithm
module MergeSort
  extend self

  def self.merge(array)
    return array if array.length == 1

    left = merge array.slice(0, array.length / 2)
    right = merge array.slice(array.length / 2, array.length)
    sort(left, right)
  end

  private

  def sort(left, right)
    sorted = []
    l = 0
    r = 0
    while sorted.length < (left.length + right.length)
      to_push, l_inc, r_inc = choose(left[l], right[r])
      sorted.push(to_push)
      l += l_inc
      r += r_inc
    end
    sorted
  end

  def choose(left_value, right_value)
    which_value = which(left_value, right_value)
    if which_value == "left"
      [left_value, 1, 0] # choose the left value and increment l, not r
    elsif which_value == "right"
      [right_value, 0, 1] # choose the right value and increment r, not l
    end
  end

  def which(left_value, right_value)
    if left_value && right_value
      left_value <= right_value ? "left" : "right"
    elsif left_value
      "left"
    elsif right_value
      "right"
    end
  end
end

# why are there multiple methods, not just a single "sort" method?
# a single sort method is fine. this project runs RuboCop which has
# a strict limit on line length and code complexity. and it was a
# fun puzzle figuring out how to divide up the "work" of merge
# into smaller methods
