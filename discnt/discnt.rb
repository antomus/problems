#!/usr/bin/env ruby

class DiscountProcessor

  def initialize(input_file, output_file)
    @input_file = input_file || "discnt.in"
    @output_file = output_file || "discnt.out" 
    @input_array, @percentage_without_discount = read_input_data
  end

  def execute
    File.open(@output_file, "w") do |file| 
      file.puts calculate_discount 
    end
  end

  private

  def read_input_data
    data = File.readlines(@input_file)

    raise "Input file should contain 2 lines" if data.length != 2

    data = data.map(&:chomp)

    [data[0].split.map(&:to_i), ((100 - data[1].to_f) / 100)]
  end

  def insertion_sort(array)

    array.each_with_index do |el, i|
      while i > 0 and el < array[i - 1] do
        array[i - 1], array[i] = array[i], array[i - 1]
        i -= 1
      end
    end
    
    array
  end

  def calculate_discount
    array = insertion_sort(@input_array)

    array.each_with_index do |el, i|
      if i > 0 && i % 3 == 0
        array[i] = array.pop * @percentage_without_discount
        array.unshift el
      end
    end

    array.reduce(:+)
  end
end

processor = DiscountProcessor.new(ARGV[0], ARGV[1])

processor.execute
