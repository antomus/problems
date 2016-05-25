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
      0
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
