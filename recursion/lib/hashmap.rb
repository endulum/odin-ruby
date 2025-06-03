module HashMap
  module_function

  def encode(string)
    hash_code = 0
    string.each_char { |char| hash_code = 17 * (hash_code + char.ord) }
    hash_code
  end

  # HashMap LinkedList node
  class Node
    attr_accessor :key, :value, :next

    def initialize(key, value = nil)
      @key = key
      @value = value
      @next = nil
    end
  end

  # MashMap LinkedList list
  class List
    attr_reader :head, :tail

    def initialize
      @head = nil
      @tail = nil
    end

    def append(key, value)
      node = Node.new(key, value)
      if @tail
        @tail.next = node
        @tail = node
      else
        @tail = node
        @head = node
      end
    end

    def each
      current_node = @head
      while current_node
        yield current_node
        current_node = current_node.next
      end
    end

    def find_node_by_key(key)
      each { |node| return node if node.key == key }
      nil
    end

    def to_string
      string = ""
      each { |node| string += "{ \"#{node.key}\" => \"#{node.value}\" } -> " }
      string += "nil"
      string
    end
  end

  # HashMap map
  class Map
    def initialize
      @size = 16
      @bucket_array = Array.new(@size)
      @bucket_count = 0
      @entry_count = 0
      @load_factor = 0.8
    end

    def hash(key)
      code = HashMap.encode(key)
      code % @size
    end

    def set(key, value)
      index = hash(key)
      if @bucket_array[index].nil?
        to_new_bucket(index, key, value)
      else
        to_existing_bucket(index, key, value)
      end
    end

    def get(key)
      index = hash(key)
      bucket = @bucket_array[index]
      return nil unless bucket

      node = bucket.find_node_by_key(key)
      node&.value
    end

    def each(&)
      @bucket_array.each(&)
    end

    private

    def to_new_bucket(index, key, value)
      new_list = HashMap::List.new
      new_list.append(key, value)
      @bucket_array[index] = new_list
      @bucket_count += 1
      @entry_count += 1
    end

    def to_existing_bucket(index, key, value)
      list = @bucket_array[index]
      existing_node = list.find_node_by_key(key)
      if existing_node
        overwrite_value(existing_node, value)
      else
        add_value(list, key, value)
      end
    end

    def add_value(list, key, value)
      list.append(key, value)
      @entry_count += 1
    end

    def overwrite_value(node, value)
      node.value = value
    end
  end
end
