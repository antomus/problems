#!/usr/bin/env ruby

require_relative "../lib/quick_sort"

class HamsterCountProcessor
  include QuickSort

    def initialize(input_file, output_file)
      @input_file = input_file || "hamstr.in"
      @output_file = output_file || "hamstr.out" 
      @input_array = read_input_data
    end

    def execute
      IO.write( @output_file, max_hamster_count )
    end

    def max_hamster_count
      7
    end

    private

    def read_input_data
      data = []

      IO.foreach(@input_file) { |line| data << line.chomp }

      raise "Input file should contain 2 lines" if data.length != 2
      food_for_day = data[0].to_i
      hamsters_count = data[1].to_i

      [food_for_day, hamsters_count, data.slice(2, a.length - 1).split]
    end

  end

  processor = HamsterCountProcessor.new(ARGV[0], ARGV[1])

  processor.execute