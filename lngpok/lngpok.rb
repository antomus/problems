#!/usr/bin/env ruby

require_relative "../lib/index"

class LongPokerProcessor
  include QuickSort

    MIN_NUM = 0
    MAX_NUM = 1000000

    def initialize(input_file, output_file)
      @input_file = input_file || "lngpok.in"
      @output_file = output_file || "lngpok.out" 
      @input_array = read_input_data
    end

    def execute
      IO.write( @output_file, longest_sequence_length )
    end

    def longest_sequence_length
      input_length = @input_array.length
      data = quick_sort(@input_array)
      data.delete(0)
      # puts data.length
      # puts input_length
      # return
      return input_length if data.empty?

      data_length = data.length
      zeros_count = input_length - data_length
      data = data.uniq
      data_range = sequence_range(data.first, data.last, zeros_count)
      sequences = generate_sequences(data_range, input_length)
      matching_sequences = find_matching_sequences(sequences, data, zeros_count)
      #puts matching_sequences.inspect
      max_sequence_length(matching_sequences)
    end

    private

    def max_sequence_length(array)
      max = 0

      array.each do |el|
        el_length = el.length
        if max < el_length
          max = el_length
        end
      end

      max
    end

    def find_matching_sequences(sequences, data, zeros_count)
      sequences.find_all { |seq| (seq - data).length <= zeros_count }
    end

    def generate_sequences(data_range, input_length)
      array = data_range.to_a
      array_length = array.length
      # puts array_length
      (0...array_length).map do |i|
        (i...array_length).map do |j|
          array[i..j]
        end
      end.flatten(1).find_all { |seq| seq.length <= input_length }
    end

    def sequence_range(min, max, zeros_count)
      left = (min - zeros_count) > MIN_NUM ? min - zeros_count : MIN_NUM
      right = (max + zeros_count) < MAX_NUM ? max + zeros_count : MAX_NUM
      (left..right)
    end

    def read_input_data
      data = IO.read(@input_file).chomp

      raise "Input file cannont be empty" if data.empty?

      data.split.map! { |n| n.to_i }
    end
  end

  processor = LongPokerProcessor.new(ARGV[0], ARGV[1])

  processor.execute