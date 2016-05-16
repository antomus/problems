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
      i = 0
      j = 0
      # k = data_length - 1
      # l = 1
      max = MIN_NUM

      while i < data_length
        while j < data_length
          seq_length = (data[j] - data[i]).abs
          # puts i
          # puts j
          # puts seq.inspect
          # puts seq_length
          sub_length = seq_length - data[i..j].length
          # puts sub_length

          if seq_length > 0 and (sub_length == 0 || sub_length <= zeros_count) 
            el = (seq_length + (zeros_count - sub_length))

            if max < el
              max = el
            end
          end

          j += 1
        end
        i +=1
        j = 1
      end

      # while k > 1
      #   while l < data_length
      #     seq = (data[l]..data[k]).to_a
      #     # puts i
      #     # puts j
      #     # puts seq.inspect
      #     sub = seq - data[l..k]
      #     #puts sub.inspect
      #     sub_length = sub.length

      #     if seq.length > 0 and (sub_length == 0 || sub_length <= zeros_count)
      #       sequences << seq
      #     end

      #     l += 1
      #   end
      #   k -=1
      #   j = 1
      # end
      max
    end

    def read_input_data
      data = IO.read(@input_file).chomp
      # puts @input_file
      # puts data.inspect
      raise "Input file cannont be empty" if data.empty?

      data.split.map! { |n| n.to_i }
    end
  end

  processor = LongPokerProcessor.new(ARGV[0], ARGV[1])

  processor.execute
