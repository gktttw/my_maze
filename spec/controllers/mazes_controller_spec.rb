require 'rails_helper'

RSpec.describe "MazesControllers", type: :request do
  describe "GET index" do
    it "returns http success" do
      allow(Maze).to receive_message_chain(:order, :all).and_return([])
      get "/mazes"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET show" do
    let(:target_maze) {
      FactoryBot.create(:maze)
    }
    context "when maze exists" do
      it "returns http success" do
        expect(Maze).to receive(:find).and_return(target_maze)
        get "/mazes/#{target_maze.id}"
        expect(response).to have_http_status(:success)
      end
    end

    context "when maze does not exist" do
      it "returns http not found" do
        expect(Maze).to receive(:find).and_raise(
          ActiveRecord::RecordNotFound.new("cannot find maze id: -1")
        )
        get "/mazes/-1"
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "POST create" do
    context "when create success" do
      it "redirects to show" do
        expect(Maze).to receive(:create_maze).and_return(FactoryBot.create(:maze))
        post "/mazes", params: { size: 5 }
        expect(response).to redirect_to(maze_path(Maze.last))
      end
    end

    context "when create not success" do
      it "renders new" do
        expect(Maze).to receive(:create_maze).and_raise(
          MazeGenerator::MazeError.new("some err")
        )
        post "/mazes", params: { size: 5 }
        expect(flash[:alert]).to eq("some err")
        expect(response).to render_template(:new)
      end
    end
  end
end
