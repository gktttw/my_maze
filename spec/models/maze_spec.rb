require 'rails_helper'

RSpec.describe Maze, type: :model do
  it 'saves data to db' do
    m = Maze.create_maze(5)
    expect(m.size).to eq(5)
    expect(m.grid).to be_a(Array)
    expect(m.solution).to be_a(Array)
    expect(m.persisted?).to be_truthy
  end
end
