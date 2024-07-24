class Maze < ApplicationRecord
  validates :size, presence: true
  validates :grid, presence: true

  def self.create_maze(size)
    m = MazeGenerator.new(size)
    create!(size: size, grid: m.grid.to_json, solution: m.solve.to_json)
  end

  def grid
    JSON.parse(super)
  end

  def solution
    JSON.parse(super) if super
  end
end
