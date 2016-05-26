#!/usr/bin/env ruby
class SigKeyProcessor

    def initialize(input_file, output_file)
      @input_file = input_file || "sigkey.in"
      @output_file = output_file || "sigkey.out" 
      @total_pairs_count, @keys_array = read_input_data
    end

    def execute
      IO.write( @output_file, key_pairs_number )
    end

    def key_pairs_number
      counter = 0
      @keys_array.each_with_index do |key,i|
        #@keys_array.delete(key)
        @keys_array.each_with_index do |other_key,j|
          next if @keys_array[i].nil? || @keys_array[j].nil?
          sum_str = (key + other_key).chars
          next if !sum_str.include?("a")
          min = sum_str.min
          max = sum_str.max
          sum_str_length = sum_str.length
          #sequence_length = (sum_str[0]..sum_str[sum_str_length - 1]).to_a.length
          sequence_length = max.ord - min.ord + 1

          #puts "sum_str_length #{sum_str_length}"
          #puts "sequence_length #{sequence_length}"

          if sequence_length == sum_str_length
            counter += 1
            @keys_array[i] = nil
            @keys_array[j] = nil
          end
        end
      end
      counter
    end

    private

    def read_input_data
      data = []
      IO.foreach(@input_file) { |line| data << line.chomp }

      raise "Input file cannont be empty" if data.empty?

      [ data[0].to_i, data[1..data.length] ]

    rescue Errno::ENOENT => e
      puts "File #{@input_file} is not found"
    end

  end

  processor = SigKeyProcessor.new(ARGV[0], ARGV[1])

  processor.execute
