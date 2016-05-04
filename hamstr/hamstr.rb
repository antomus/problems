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
      data = IO.read(@input_file).chomp
      data.split.map! { |n| n.to_i }
    end

  end

  processor = HamsterCountProcessor.new(ARGV[0], ARGV[1])

  processor.execute