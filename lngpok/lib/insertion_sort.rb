module InsertionSort
  def insertion_sort(array, &compare)

    array.each_with_index do |el, i|
      while i > 0 and compare.call(el, array[i - 1]) do
        array[i - 1], array[i] = array[i], array[i - 1]
        i -= 1
      end
    end
    
    array
  end

  # private

  # def compare(a, b)
  #   a < b
  # end
end