module MazeSolvers
  class Base
    attr_reader :maze
    def self.validate_size!(size)
      raise NotImplementedError
    end

    def initialize(grid, start, size)
      @grid = grid
      @start = start
      @size = size
      @solution = nil
    end

    def generate_maze
      raise NotImplementedError
    end

    def solve
      raise NotImplementedError
    end
  end
end
