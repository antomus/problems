module MergeSort

  def merge_sort(array)

    result = merge_sort_recursive(array, 0, array.length - 1)

    # Replacing the input array with the sorted result.

    array.replace(result)
  end

  private

  def merge_sort_recursive(array, left, right)
    puts "left #{left} right #{right} #{left < right}"

    if left < right

      middle = (left + right) / 2

      # Splitting the larger task into smaller subtasks and solving each recursively.

      left_part = merge_sort_recursive(array, left, middle)

      right_part = merge_sort_recursive(array, middle + 1, right)

      # Merging the results of the subproblems.

      result = merge(left_part, right_part)

      return result

    end

    # If our [left..right] range contains only one item, returning it.

    [array[left]]
  end

  def merge(left_array, right_array)

    # Creating an auxiliary array for storing the merged result.
    left_length = left_array.length
    right_length = right_array.length
    result_length =  + right_array.length

    result = [ nil ] * result_length

    # Remembering the reading positions for both subarrays.

    left_pos = right_pos = result_pos = 0

    # Picking items either from the left subarray or the right subarray,

    # depending on which item is smaller.

    while result_pos < result_length

    # If we have no more items on the left OR right item is smaller than left

    # then pick from the right subarray.
      pick_from_right_array = (left_pos >= left_length) || 
        ( (right_pos < right_length) && (right_array[right_pos] > left_array[left_pos]) )

      if pick_from_right_array

        result[result_pos] = right_array[right_pos]
        right_pos += 1

      else

        result[result_pos] = left_array[left_pos]
        left_pos += 1

      end

      result_pos += 1
    end

    result
  end
end