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

  # Binary search tree
  class Tree
    def initialize(data)
      # initialize can take ANY array, and determine what to do if sorted or not
      if data.sort == data
        @root = build(data, 0, data.length - 1)
        # data is already sorted, use recursive build
      else
        add_data(data)
        # data isn't sorted, use iterative adding
        # TODO: balancing afterward
      end
    end

    def build(data, start_index, end_index)
      return if start_index > end_index

      middle_index = middle(start_index, end_index)
      node = Node.new(data[middle_index])
      node.left = build(data, start_index, middle_index - 1)
      node.right = build(data, middle_index + 1, end_index)
      node
    end

    def add(value)
      new_node = BST::Node.new(value)
      if @root.nil?
        @root = new_node
      else
        add_node(new_node, @root)
      end
    end

    def preorder(node = @root, &)
      yield node
      preorder(node.left, &) if node.left
      preorder(node.right, &) if node.right
    end

    def inorder(node = @root, &)
      inorder(node.left, &) if node.left
      yield node
      inorder(node.right, &) if node.right
    end

    def postorder(node = @root, &)
      postorder(node.left, &) if node.left
      postorder(node.right, &) if node.right
      yield node
    end

    def levelorder
      queue = [@root]
      visited = []
      while queue.length.positive?
        node = queue.shift
        next unless node

        yield node
        visited.push(node)
        queue.push(node.left) if node.left
        queue.push(node.right) if node.right
      end
    end

    def pretty_print(node = @root, prefix = "", is_left = true)
      pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
      puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
      pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end

    private

    def middle(start_index, end_index)
      start_index + ((end_index - start_index) / 2)
    end

    def add_data(data)
      queue = data.dup
      while queue.length.positive?
        value = queue.pop
        add(value)
      end
    end

    def add_node(new_node, node)
      if new_node > node
        node.right.nil? ? node.right = new_node : add_node(new_node, node.right)
      elsif new_node < node
        node.left.nil? ? node.left = new_node : add_node(new_node, node.left)
      end
    end
  end
end
