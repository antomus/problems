arr = [50, 20, 30, 17, 100]

arr = arr.sort

arr.each_with_index do |el, i|
  if i > 0 && i % 3 == 0
    tmp = arr[i]
    arr[i] = arr.pop * 0.9
    arr.unshift tmp
  end
end

arr.reduce(:+)
