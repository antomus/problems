#!/usr/bin/env ruby

require_relative "lib/index"
#require "pp"

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
      # puts data.inspect
      # puts @input_array.inspect
      return input_length if data.empty?

      data_length = data.length
      zeros_count = input_length - data_length
      data = data.uniq

      find_max_sequence(data, zeros_count)
      #puts matching_sequences
      #max_sequence_length(matching_sequences)
    end

    private

    def find_max_sequence(data, zeros_count)

    end

    def read_input_data
      data = IO.read(@input_file).chomp
      # puts @input_file
      # puts data.inspect
      raise "Input file cannont be empty" if data.empty?

      data.split.map! { |n| n.to_i }
    end

    def get_sequence(data, middle, left)
      puts "middle #{middle}"
      seq_length = (data[middle] - data[left]).abs + 1
      puts "seq_length #{seq_length}"
      difference = seq_length - data[left..middle].length
      puts "difference #{difference}"
      [seq_length, difference]
    end

    def find_max_sequence(data, zeros_count)
      #find_max_sequence([1,3,5,7,10,15,20], 3))
      # [9, 10, 12, 14, 15, 40, 50] , 2

      left = 0
      middle = nil

      right = data.length - 1

      while right - left > 1
        puts "left #{left}"
        puts "right #{right}"
        puts "data #{data.inspect}"
        puts "zeros_count #{zeros_count}"

        guess = left + (right - left) / 2

        middle = guess if middle.nil?
        seq_length, difference = get_sequence(data, middle, left)


        if difference == zeros_count
          loop do
            middle = middle + 1
            seq_length, difference = get_sequence(data, middle, left)
            return get_sequence(data, middle - 1, left)[0] if difference > zeros_count
          end
        end

        middle = guess

        if difference < zeros_count
          left = middle
        elsif difference > zeros_count
          right = middle
        end

      end
    end
  end

  processor = LongPokerProcessor.new(ARGV[0], ARGV[1])

  processor.execute
