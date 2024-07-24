require 'rails_helper'

RSpec.describe "MazeGenerator", type: :lib do
  let(:size) { 9 }
  describe 'it generates maze' do
    subject { MazeGenerator.new(size) }
    it 'has a valid grid' do
      g = subject.grid
      expect(g).to be_a(Array)
      expect(g.length).to eq(size)
      expect(g[0].length).to eq(size)
    end

    it 'solves a maze' do
      m = subject
      m.solve
      expect(m.solve).to be_a(Array)
      start = [1, 1]
      expect(m.solve[start[0]][start[1]]).to eq(3)

      current = [1, 1]
      while current != [size - 2, size - 2]
        m.solve[current[0]][current[1]] = -1
        next_cell = nil
        MazeGenerator::DIRECTIONS.each do |dx, dy|
          next_pos = [current[0] + dx, current[1] + dy]
          if m.solve[next_pos[0]][next_pos[1]] == 3
            next_cell = next_pos
            break
          end
        end
        break if next_cell.nil?
        current = next_cell
      end

      expect(current).to eq([size - 2, size - 2])
    end
  end

  describe 'it validates input' do
    it 'raises error when size is less than 5' do
      expect { MazeGenerator.new(4) }.to raise_error(MazeGenerator::MazeError)
    end
    it 'raises error when size is greater than 61' do
      expect { MazeGenerator.new(77) }.to raise_error(MazeGenerator::MazeError)
    end
    it 'raises error when size is even' do
      expect { MazeGenerator.new(8) }.to raise_error(MazeGenerator::MazeError)
    end
  end
end
