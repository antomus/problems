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
      # puts data.inspect
      data.delete(0)
      data_length = data.length
      zeros_count = input_length - data_length
      data = data.uniq
      data_range = sequence_range(data.first, data.last, zeros_count)
      sequences = generate_sequences(data_range, input_length)
      puts sequences.inspect
      matching_sequences = find_matching_sequences(sequences, data)
      puts matching_sequences.inspect
      longest_length = max_sequence_length(matching_sequences)
      # puts longest_length + zeros_count
      longest_length + zeros_count
    end

    private

    def numbers_missing_for_sequence?(array)
      all_numbers = (array.first..array.last).to_a
      all_numbers - array
    end

    def is_sequence?(array)
      retrun false if array.length == 0
      numbers_missing_for_sequence?(array).length == 0
    end

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

    def find_matching_sequences(sequences, data)
      result = []
      data_length = data.length

      data.each_with_index do |_, i|
        result << sequences.find_all { |seq| seq - data[i..data_length] }
      end

      result
    end

    def generate_sequences(data_range, data_length)
      (1..data_length).to_a.inject([]) do |mem, num|
        mem += data_range.each_cons(num).to_a
        mem
      end
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