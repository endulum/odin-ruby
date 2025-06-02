module LinkedList
  # LinkedList node
  class Node
    attr_accessor :data, :next

    def initialize(data = nil)
      @data = data
      @next = nil
    end
  end

  # LinkedList list
  class List
    attr_reader :head, :tail

    def initialize
      @head = nil
      @tail = nil
    end

    def prepend(data)
      node = Node.new(data)
      if @head
        node.next = @head
        @head = node
      else
        @head = node
        @tail = node
      end
    end

    def append(data)
      node = Node.new(data)
      if @tail
        @tail.next = node
        @tail = node
      else
        @tail = node
        @head = node
      end
    end

    def pop
      node = @tail.dup
      @tail = nil
      node
    end

    def size
      total = 0
      each { total += 1 }
      total
    end

    def at(index)
      current_index = 0
      each do |node|
        return node.data if current_index == index

        current_index += 1
      end
      nil
    end

    def contains?(data)
      each { |node| return true if node.data == data }
      false
    end

    def find(data)
      current_index = 0
      each do |node|
        return current_index if node.data == data

        current_index += 1
      end
      nil
    end

    def to_s
      string = ""
      each { |node| string += "( #{node.data} ) -> " }
      string += "nil"
      string
    end

    private

    def each
      current_node = @head
      while current_node
        yield current_node
        current_node = current_node.next
      end
    end
  end
end
