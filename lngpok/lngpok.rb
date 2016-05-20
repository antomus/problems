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
      data_length = data.length
      left_bound = 0
      right_bound = data_length - 1
      mid = data_length / 2
      el = 0

      max = MIN_NUM

      while left_bound >= 0 && left_bound < mid


 

        seq_length = (data[mid] - data[left_bound]).abs + 1
        sub_length = seq_length - data[left_bound..mid].length
        el = (seq_length + (zeros_count - sub_length)) if sub_length <= zeros_count
        puts data.inspect
        puts "data[mid] #{data[mid]}"
        puts "data[left_bound] #{data[left_bound]}"
        puts "seq_length #{seq_length}"
        puts "data[left_bound..mid].length #{data[left_bound..mid].length}"
        puts "sub_length #{sub_length}"
        puts "el #{el}"
        puts "zeros_count #{zeros_count}"
        puts "left_bound #{left_bound}"
        puts "right_bound #{right_bound}"
        puts "mid #{mid}"
        puts

        if sub_length <= zeros_count
          left_bound = mid + 1
        end
          
        if sub_length > zeros_count
          right_bound = mid - 1
        end

        mid = left_bound + ( right_bound - left_bound ) / 2

      end

      el
    end

    def read_input_data
      data = IO.read(@input_file).chomp
      # puts @input_file
      # puts data.inspect
      raise "Input file cannont be empty" if data.empty?

      data.split.map! { |n| n.to_i }
    end


    def foo
      array = [9, 10, 12, 14, 15, 40, 50]

      zeros_count = 2
      max_max = array.length - 1
      min_min = 0
      min = min_min
      max = max_max
      el = min_min

      loop do
        if max > max_max || min < min_min 
          break
        end

        guess = (min + max) / 2

        seq_length = (array[guess] - array[min]).abs + 1
        sub_length = seq_length - array[min..guess].length
        el = (seq_length + (zeros_count - sub_length)) if sub_length <= zeros_count
        puts el

        if array[guess] < zeros_count
          min=guess + 1
        else
          max=guess - 1
        end
      end

      el
    end
  end

  processor = LongPokerProcessor.new(ARGV[0], ARGV[1])

  processor.execute
