#!/usr/bin/env ruby

require_relative "../lib/quick_sort"

class DiscountProcessor
  include QuickSort

  def initialize(input_file, output_file)
    @input_file = input_file || "discnt.in"
    @output_file = output_file || "discnt.out" 
    @input_array, @percentage_without_discount = read_input_data
  end

  def execute
    IO.write( @output_file, ('%.02f' % calculate_discount) )
  end

  private

  def read_input_data
    data = []

    IO.foreach(@input_file) { |line| data << line.chomp }

    raise "Input file should contain 2 lines" if data.length != 2

    [data[0].split.map! { |n| n.to_f }, ((100.0 - data[1].to_f) / 100.0)]
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
    array = quick_sort(@input_array)
    array_length = array.length

    ops_num = array.length / 3

    left_sum = array[0...(array_length - ops_num)].reduce(&:+)

    right_sum = array[(array_length - ops_num )...array_length].inject(0) do |memo, el| 
      memo += el.to_i * @percentage_without_discount
      memo
    end

    left_sum + right_sum
  end
end

processor = DiscountProcessor.new(ARGV[0], ARGV[1])

processor.execute
