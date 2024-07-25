class MazeGenerator
  attr_accessor :size, :grid, :solution
  DIRECTIONS = [[0, 1], [1, 0], [0, -1], [-1, 0]]

  """
    solver_class: MazeSolvers::Base class
    size: Integer
  """
  def initialize(size, solver_class)
    solver_class.validate_size!(size)
    @size = size
    @grid = Array.new(size) { Array.new(size, 1) }
    @start = [1, 1]
    @solution = nil
    @solver = solver_class.new(@grid, @start, @size)
  end

  def build
    @solver.generate_maze
    @solution = @solver.solve
  end

  """
    display the maze helper
  """
  def display
    @grid[1][1] = "S"
    @grid[@size - 2][@size - 2] = "E"
    @grid.each do |row|
      formatted_row = row.map do |g|
        case g
        when 1 # wall
          "X"
        when 0 # path
          "O"
        else
          g
        end
      end
      puts formatted_row.join(" ")
    end
    @grid[1][1] = 0
    @grid[@size - 2][@size - 2] = 0
  end

  """
    display the maze solution helper
  """
  def display_solution
    @solution[1][1] = "S"
    @solution[@size - 2][@size - 2] = "E"
    @solution.each do |row|
      formatted_row = row.map do |g|
        case g
        when 1 # wall
          "X"
        when 0 # path
          "O"
        when 3 # solution
          "$"
        else
          g
        end
      end
      puts formatted_row.join(" ")
    end
    @solution[1][1] = 0
    @solution[@size - 2][@size - 2] = 0
  end

  class MazeError < StandardError
  end
end
