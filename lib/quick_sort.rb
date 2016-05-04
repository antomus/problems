module QuickSort

  def quick_sort(array)
    quick_sort_recursive(array, 0, array.length - 1)
  end

  private

  def quick_sort_recursive(array, left, right)

    pivot = get_pivot(array, left, right)
    left_write_pos = left
    right_write_pos = right

    while left_write_pos <= right_write_pos do

      while array[left_write_pos] < pivot do
        left_write_pos += 1
      end

      while pivot < array[right_write_pos] do
        right_write_pos -= 1
      end

      if left_write_pos <= right_write_pos
        array[right_write_pos], array[left_write_pos] = array[left_write_pos], array[right_write_pos]
        left_write_pos += 1
        right_write_pos -= 1
      end
    end

    # Sort left and right part recursively, if they are not empty.

    if left < left_write_pos - 1
      quick_sort_recursive(array, left, left_write_pos - 1)
    end

    if left_write_pos < right
      quick_sort_recursive(array, left_write_pos, right)
    end

    array
  end

  def get_pivot(array, left, right)
    # Take the leftmost item by default.
    array[left]
  end
end