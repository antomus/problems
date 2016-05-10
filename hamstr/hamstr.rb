#!/usr/bin/env ruby

require_relative "../lib/index"

class HamsterCountProcessor
  include InsertionSort

    def initialize(input_file, output_file)
      @input_file = input_file || "hamstr.in"
      @output_file = output_file || "hamstr.out" 
      @food_for_day, @hamsters_count, @hamsters_data = read_input_data
    end

    def execute
      IO.write( @output_file, max_hamster_count )
    end

    def max_hamster_count
      max_val = 0

      sorted_data = insertion_sort(@hamsters_data) do |a, b| 
        (a[0] < b[0]) #(a[1] < b[1])  or
      end

      puts sorted_data.inspect

      sorted_data.each_with_index do |el, i|

        chunk_length = sorted_data[0..i].length

        max_val = sorted_data[0..i].inject(0) do |sum, el| 
          sum += (el[0] + el[1] * (chunk_length - 1))
          sum
        end

        puts max_val 
        puts @food_for_day
        puts max_val > @food_for_day

        if max_val > @food_for_day

          if i == 0 && el[0] <= @food_for_day
            return 1
          else
            return i
          end

        elsif max_val == @food_for_day && @food_for_day > 0
          return i + 1
        end
      end

      @hamsters_count
    end

    private

    def compare(a, b)
      (a[1] < b[1]) && (a[0] < b[0])  
    end

    def read_input_data
      data = []

      IO.foreach(@input_file) { |line| data << line.chomp }
      food_for_day = data[0].to_i
      hamsters_count = data[1].to_i

      raise "Input file cannont contain less than 2 lines" if data.length < 2

      data = data.slice(2, data.length - 1).map do |line| 
        line.split(" ").map(&:to_i)
      end

      [food_for_day, hamsters_count, data]
    end

  end

  processor = HamsterCountProcessor.new(ARGV[0], ARGV[1])

  processor.execute