class CreateMazes < ActiveRecord::Migration[7.1]
  def change
    create_table :mazes do |t|
      t.integer :size, null: false
      t.json :grid, null: false
      t.json :solution, null: false
      t.timestamps
    end
  end
end
