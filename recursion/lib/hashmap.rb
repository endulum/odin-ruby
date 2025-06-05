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

    def length
      total = 0
      each { total += 1 }
      total
    end

    def find_by_key(key)
      each { |node| return node if node.key == key }
      nil
    end

    def remove_by_key(key)
      if @head && @head.key == key # check head first
        @head = @head.next
      else
        each do |node|
          next unless node.next && node.next.key == key

          node.next = (node.next.next || nil)
        end
      end
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
    attr_reader :size, :length

    def initialize
      @size = 16
      @bucket_array = Array.new(@size)
      @bucket_count = 0
      @length = 0
    end

    def hash(key)
      code = HashMap.encode(key)
      code % @size
    end

    def set(key, value)
      index = hash(key)
      add_bucket(index) if @bucket_array[index].nil?
      list = @bucket_array[index]
      add_key(list, key, value)
    end

    def get(key)
      index = hash(key)
      list = @bucket_array[index]
      return nil if list.nil?

      get_key(list, key)
    end

    def remove(key)
      index = hash(key)
      list = @bucket_array[index]
      return if list.nil?

      remove_key(list, key)
      remove_bucket(index) if list.head.nil?
    end

    def each(&)
      @bucket_array.each(&)
    end

    def each_bucket(&)
      @bucket_array.compact.each(&)
    end

    def keys
      total_keys = []
      each_bucket { |bucket| bucket.each { |node| total_keys.push node.key } }
      total_keys
    end

    def values
      total_values = []
      each_bucket { |bucket| bucket.each { |node| total_values.push node.value } }
      total_values
    end

    def entries
      total_entries = []
      each_bucket { |bucket| bucket.each { |node| total_entries.push [node.key, node.value] } }
      total_entries
    end

    def clear
      @bucket_array.map! { nil }
      @length = 0
      @bucket_count = 0
    end

    def threshold
      @size * 0.8
    end

    def should_grow?
      threshold < @length
    end

    private

    def add_key(list, key, value)
      existing_node = list.find_by_key(key)
      if existing_node
        existing_node.value = value
      else
        list.append(key, value)
        @length += 1
        grow_buckets if should_grow?
      end
    end

    def get_key(list, key)
      value = nil
      list.each { |node| value = node.value if node.key == key }
      value
    end

    def remove_key(list, key)
      list.remove_by_key(key)
      @length -= 1
    end

    def add_bucket(index)
      new_list = HashMap::List.new
      @bucket_array[index] = new_list
      @bucket_count += 1
    end

    def remove_bucket(index)
      list = @bucket_array[index]
      @length -= list.length
      @bucket_array[index] = nil
      @bucket_count -= 1
    end

    def grow_buckets
      @size *= 2
      old_buckets = @bucket_array.dup
      clear
      old_buckets.compact.each { |bucket| bucket.each { |node| set(node.key, node.value) } }
    end
  end
end
