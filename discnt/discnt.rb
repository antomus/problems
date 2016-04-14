#!/usr/bin/env ruby

class DiscountProcessor

  def initialize(input_file, output_file)
    @input_file = input_file || "discnt.in"
    @output_file = output_file || "discnt.out" 
    @input_array, @discount = read_input_data
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

    [data[0].split.map(&:to_i), data[1].to_f / 100]
  end

  def calculate_discount
    arr = @input_array.sort

    arr.each_with_index do |el, i|
      if i > 0 && i % 3 == 0
        tmp = arr[i]
        arr[i] = arr.pop * @discount
        arr.unshift tmp
      end
    end

    arr.reduce(:+)
  end
end

processor = DiscountProcessor.new(ARGV[0], ARGV[1])

processor.execute
