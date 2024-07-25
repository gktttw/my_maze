module MazeSolvers
  class DfsSolver < Base
    def self.validate_size!(size)
      raise MazeGenerator::MazeError.new("Size should be odd number") if size.even?
      raise MazeGenerator::MazeError.new("Size should be greater than 5") if size < 5
      raise MazeGenerator::MazeError.new("Size should be less than 61") if size > 61
    end

    def initialize(grid, start, size)
      super
    end

    def generate_maze
      current_x, current_y = @start
      dfs(current_x, current_y)
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

    private

    def dfs(x, y)
      @grid[x][y] = 0
      MazeGenerator::DIRECTIONS.shuffle.each do |dx, dy|
        nx, ny = x + dx * 2, y + dy * 2
        if nx >= 0 && nx < @size && ny >= 0 && ny < @size && @grid[nx][ny] == 1
          @grid[x + dx][y + dy] = 0
          dfs(nx, ny)
        end
      end
    end

    def dfs_solve(x, y, visited, path)
      return false if x < 0 || y < 0 || x >= @size || y >= @size
      return false if @grid[x][y] == 1 || visited[x][y]

      path << [x, y]
      visited[x][y] = true

      return true if @grid[x][y] == "E"

      MazeGenerator::DIRECTIONS.each do |dx, dy|
        return true if dfs_solve(x + dx, y + dy, visited, path)
      end

      path.pop
      false
    end
  end
end
