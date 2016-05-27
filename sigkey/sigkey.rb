#!/usr/bin/env ruby
class SigKeyProcessor

  ALPHABET_ARRAY = [ 97, 98, 99, 100,
                    101, 102, 103, 104,  
                    105, 106, 107, 108, 
                    109, 110, 111, 112, 
                    113, 114, 115, 116,  
                    117, 118, 119, 120,
                    121, 122 ].freeze

  def initialize(input_file, output_file)
    @input_file = input_file || "sigkey.in"
    @output_file = output_file || "sigkey.out" 
    @total_pairs_count, @keys_array = read_input_data
    @alphabet_sums = {}
    ALPHABET_ARRAY.each_with_index do |_,i| 
      @alphabet_sums[ALPHABET_ARRAY[0..i].length] = ALPHABET_ARRAY[0..i].reduce(:+)
    end
    @alphabet_sums .freeze
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


        #puts "sum_str_length #{sum_str_length}"
        #puts "sequence_length #{sequence_length}"

        if key_pair?(key, other_key)
          counter += 1
          @keys_array[i] = nil
          @keys_array[j] = nil
        end
      end
    end
    counter
  end

  private

  def key_pair?(key, other_key)
    sum_str = key + other_key
    pair_sum = sum_str.each_byte.reduce(&:+)
    @alphabet_sums[sum_str.length] && @alphabet_sums[sum_str.length] == pair_sum
  end

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
