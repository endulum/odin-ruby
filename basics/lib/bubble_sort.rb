def bubble_sort array_to_sort
  iterations = 0
  swaps = 0

  loop do
    iterations += 1
    p "This is iteration ##{iterations}, max expected comparisons are #{array_to_sort.length - iterations}."
    swaps = 0
    array_to_sort[0..(-1 - iterations)].each_with_index do |element, index|
      p "Elements to compare: #{[array_to_sort[index], array_to_sort[index + 1]]}"

      if (array_to_sort[index] > array_to_sort[index + 1])
        p "#{array_to_sort[index]} is greater than #{array_to_sort[index + 1]}, swapping..."
        
        temp = array_to_sort[index]
        array_to_sort[index] = array_to_sort[index + 1]
        array_to_sort[index + 1] = temp
        swaps += 1
      end
    end
    p "Completed iteration with #{swaps} swaps."
    break if swaps == 0
    p "Array is not sorted, let's go again."
  end

  array_to_sort
end