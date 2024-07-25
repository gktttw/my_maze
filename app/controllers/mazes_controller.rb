class MazesController < ApplicationController
  def index
    @mazes = Maze.order(size: :asc).all
  end

  def show
    @maze = Maze.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    Rails.logger.error(e.message)
    render_404
  end

  def create
    size = create_maze_params[:size]
    @maze = Maze.create_maze(size)

    redirect_to maze_path(@maze)
  rescue MazeGenerator::MazeError, ActionController::ParameterMissing => e
    Rails.logger.error(e.message)
    flash[:alert] = e.message
    render :new
  end

  private

  def create_maze_params
    size = params.require(:size).to_i

    { size: size }
  end
end
