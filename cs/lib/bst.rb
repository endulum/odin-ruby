module BST
  # Binary search tree node
  class Node
    include Comparable
    attr_accessor :value, :left, :right

    def initialize(value)
      @value = value
      @left = nil
      @right = nil
    end

    def <=>(other)
      other_value = other.is_a?(Node) ? other.value : other
      return 0 if @value == other_value
      return 1 if @value > other_value
      return -1 if @value < other_value

      raise "Values #{@value} and #{other.value} could not be compared."
    end

    def self.insert(new_node, node)
      return if new_node == node

      if new_node > node
        node.right.nil? ? node.right = new_node : insert(new_node, node.right)
      elsif new_node < node
        node.left.nil? ? node.left = new_node : insert(new_node, node.left)
      end
    end

    def self.remove(value, node)
      if node > value
        node.left = remove(value, node.left) if node.left
      elsif node < value
        node.right = remove(value, node.right) if node.right
      else
        return node.right unless node.left
        return node.left unless node.right

        move_successor(node)
      end
      node
    end

    def self.move_successor(node)
      successor = successor_of(node)
      node.value = successor_of(node).value
      node.right = remove(successor.value, node.right)
    end

    def self.successor_of(node)
      node = node.right
      node = node.left while node&.left
      node
    end

    def self.pretty_print(node, prefix = "", is_left: true)
      pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", is_left: false) if node.right
      puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
      pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", is_left: true) if node.left
    end
  end

  # Binary search tree
  class Tree
    def initialize(data, balance_after: true)
      # initialize can take ANY array, and determine what to do if sorted or not
      if data.sort == data && data.uniq == data # data is ready, use recursive build
        @root = build(data, 0, data.length - 1)

      else # data isn't sorted, use iterative adding
        add_data(data)
        balance if balance_after
      end
    end

    def build(data, start_index, end_index)
      return if start_index > end_index

      middle_index = (start_index + end_index) / 2
      node = Node.new(data[middle_index])
      node.left = build(data, start_index, middle_index - 1)
      node.right = build(data, middle_index + 1, end_index)
      node
    end

    def insert(value, balance_after: false)
      new_node = BST::Node.new(value)
      if @root.nil?
        @root = new_node
      else
        Node.insert(new_node, @root)
        balance if balance_after
      end
    end

    def remove(value, balance_after: false)
      return if @root.nil?

      @root = Node.remove(value, @root)
      balance if balance_after
    end

    def preorder(node = @root, &)
      return unless node

      yield node
      preorder(node.left, &) if node.left
      preorder(node.right, &) if node.right
    end

    def inorder(node = @root, &)
      return unless node

      inorder(node.left, &) if node.left
      yield node
      inorder(node.right, &) if node.right
    end

    def postorder(node = @root, &)
      return unless node

      postorder(node.left, &) if node.left
      postorder(node.right, &) if node.right
      yield node
    end

    def levelorder(&)
      queue = [@root].compact
      while queue.length.positive?
        queue.each(&)
        visited = queue.dup
        queue = []
        visited.each do |node|
          queue.push(node.left) if node.left
          queue.push(node.right) if node.right
        end
      end
    end

    def all(type = :inorder)
      all = []
      send(type) { |node| all.push(node.value) } if %i[inorder preorder postorder levelorder].include? type
      all
    end

    def height(node = @root)
      return -1 unless node

      left_height = height(node.left)
      right_height = height(node.right)
      [left_height, right_height].max + 1
    end

    def balanced?(node = @root)
      return true unless node

      left_height = height(node.left)
      right_height = height(node.right)
      return true if balanced?(node.left) && balanced?(node.right) && (left_height - right_height).abs <= 1

      false
    end

    def balance
      return if balanced?

      data = []
      inorder { |node| data.push(node.value) }
      @root = build(data, 0, data.length - 1)
    end

    def pretty_print
      Node.pretty_print(@root)
    end

    private

    def add_data(data)
      queue = data.dup
      while queue.length.positive?
        value = queue.pop
        insert(value)
      end
    end
  end
end
