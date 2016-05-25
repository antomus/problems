#!/usr/bin/env ruby
class BugTrkProcessor

    def initialize(input_file, output_file)
      @input_file = input_file || "bugtrk.in"
      @output_file = output_file || "bugtrk.out" 
      @papers_count, @paper_width, @paper_height = read_input_data
    end

    def execute
      IO.write( @output_file, board_side_length )
    end

    def board_side_length
      0
    end

    private

    def read_input_data
      data = IO.read(@input_file).chomp

      raise "Input file cannont be empty" if data.empty?

      data.split

    rescue Errno::ENOENT => e
      puts "File #{@input_file} is not found"
    end

  end

  processor = BugTrkProcessor.new(ARGV[0], ARGV[1])

  processor.execute
