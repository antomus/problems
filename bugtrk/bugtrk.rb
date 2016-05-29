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
      total_papers_square = @paper_width * @paper_height * @papers_count
      side_length = Math.sqrt(total_papers_square).round

      if side_length * side_length == total_papers_square
        return side_length
      end

      return @paper_height if @paper_width / @paper_height == 0
      return @paper_width if  @paper_height / @paper_width == 0

      lay_papers(side_length, total_papers_square)
    end

    def lay_papers(side_length, total_papers_square)
      j = 0
      total = @papers_count

      decrement = (side_length / @paper_width)
      decrement = decrement > 0 ? decrement : @paper_width
      while total > 0
        total -= decrement
        j += @paper_height
      end

      j_max

    end

    private

    def read_input_data
      data = IO.read(@input_file).chomp

      raise "Input file cannont be empty" if data.empty?

      data.split.map(&:to_i)

    rescue Errno::ENOENT => e
      puts "File #{@input_file} is not found"
    end

  end

  processor = BugTrkProcessor.new(ARGV[0], ARGV[1])

  processor.execute
