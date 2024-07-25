# == Schema Information
#
# Table name: mazes
#
#  id         :bigint           not null, primary key
#  size       :integer          not null
#  grid       :json             not null
#  solution   :json             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Maze < ApplicationRecord
  validates :size, presence: true
  validates :grid, presence: true

  def self.create_maze(size)
    m = MazeGenerator.new(size, MazeSolvers::DfsSolver)
    m.build
    create!(size: size, grid: m.grid.to_json, solution: m.solution.to_json)
  end

  def grid
    JSON.parse(super)
  end

  def solution
    JSON.parse(super) if super
  end
end
