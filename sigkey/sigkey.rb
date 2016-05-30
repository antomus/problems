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
    alphabet_sums = @alphabet_sums
    keys_array = @keys_array
    keys_array.each_with_index do |_,i|
      keys_array.each_with_index do |_,j|

        next if keys_array[i] == keys_array[j]
        sum_str = (keys_array[i] + keys_array[j]).each_byte

        min = sum_str.min
        next if min != 97

        #max = sum_str.max

        sum_str_length = sum_str.count
        # puts "sum_str_length #{sum_str_length}"
        #sequence_length = max.ord - min.ord + 1
          # puts "sequence_length #{sequence_length}"
          # puts "sum_str #{sum_str.inspect}"

        pair_sum = sum_str.reduce(&:+)
        if alphabet_sums[sum_str_length] && alphabet_sums[sum_str_length] == pair_sum
          counter += 1
          break
        end
      end
    end
    counter / 2
  end

  private

  def key_pair?(key, other_key)
    return false if key == other_key
    return false if key.nil? || other_key.nil?
    sum_str = "#{key}#{other_key}".chars.sort
    puts sum_str.inspect
    return false if sum_str.first != "a"
    (sum_str.first..sum_str.last).to_a == sum_str.length
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
