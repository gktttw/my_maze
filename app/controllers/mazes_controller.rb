class MazesController < ApplicationController
  def index
    @mazes = Maze.all
  end

  def show
    @maze = Maze.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end

  def create
    size = create_maze_params[:size].to_i

    if size < 5 || size > 61
      flash[:alert] = "Maze size must be between 5 and 61."
      render :new and return
    end

    if size.even?
      flash[:alert] = "Maze size must be an odd number."
      render :new and return
    end

    @maze = Maze.create_maze(size)
    redirect_to maze_path(@maze)
  end

  private

  def create_maze_params
    params.permit(:size)
  end
end
