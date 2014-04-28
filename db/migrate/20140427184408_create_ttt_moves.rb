class CreateTttMoves < ActiveRecord::Migration
  def change
    create_table :ttt_moves do |t|
      t.belongs_to :tic_tac_toe_game
      t.belongs_to :user
      t.integer :x_coordinate
      t.integer :y_coordinate

      t.timestamps
    end
  end
end
