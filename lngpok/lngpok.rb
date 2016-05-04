#!/usr/bin/env ruby

require_relative "../lib/quick_sort"

class LongPokerProcessor
  include QuickSort

    def initialize(input_file, output_file)
      @input_file = input_file || "lngpok.in"
      @output_file = output_file || "lngpok.out" 
      @input_array = read_input_data
    end

    def execute
      IO.write( @output_file, longest_sequence_length )
    end

    def longest_sequence_length
      7
    end

    private

    def read_input_data
      data = IO.read(@input_file).chomp
      data.split.map! { |n| n.to_i }
    end

  end

  processor = LongPokerProcessor.new(ARGV[0], ARGV[1])

  processor.execute