module BST
  # Binary search tree node
  class Node
    include Comparable

    attr_reader :value
    attr_accessor :left, :right

    def initialize(value)
      @value = value
      @left = nil
      @right = nil
    end

    def <=>(other)
      return 0 if @value == other.value
      return 1 if @value > other.value
      return -1 if @value < other.value

      raise "Values #{@value} and #{other.value} could not be compared."
    end
  end
end
