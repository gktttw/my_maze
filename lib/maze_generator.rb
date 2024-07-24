class MazeGenerator
  attr_accessor :size, :grid, :start, :end
  DIRECTIONS = [[0, 1], [1, 0], [0, -1], [-1, 0]]

  def initialize(size)
    validate_size!(size)
    @size = size
    @grid = Array.new(size) { Array.new(size, 1) }
    @start = [1, 1]
    generate_path
    @solution = nil
  end

  def validate_size!(size)
    raise MazeError.new("Size should be odd number") if size.even?
    raise MazeError.new("Size should be greater than 5") if size < 5
    raise MazeError.new("Size should be less than 61") if size > 61
  end

  def generate_path
    current_x, current_y = @start
    dfs(current_x, current_y)
  end

  def dfs(x, y)
    @grid[x][y] = 0
    DIRECTIONS.shuffle.each do |dx, dy|
      nx, ny = x + dx * 2, y + dy * 2
      if nx >= 0 && nx < @size && ny >= 0 && ny < @size && @grid[nx][ny] == 1
        @grid[x + dx][y + dy] = 0
        dfs(nx, ny)
      end
    end
  end

  def solve
    return @solution if @solution

    @grid[@size - 2][@size - 2] = "E"
    visited = Array.new(@size) { Array.new(@size, false) }
    path = []
    dfs_solve(@start[0], @start[1], visited, path)
    @grid[@size - 2][@size - 2] = 1

    @solution = Marshal.load(Marshal.dump(@grid))
    path.each do |x, y|
      @solution[x][y] = 3
    end

    @solution
  end

  def dfs_solve(x, y, visited, path)
    return false if x < 0 || y < 0 || x >= @size || y >= @size
    return false if @grid[x][y] == 1 || visited[x][y]

    path << [x, y]
    visited[x][y] = true

    return true if @grid[x][y] == "E"

    DIRECTIONS.each do |dx, dy|
      return true if dfs_solve(x + dx, y + dy, visited, path)
    end

    path.pop
    false
  end

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
