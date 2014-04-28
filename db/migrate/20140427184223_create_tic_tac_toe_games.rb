class CreateTicTacToeGames < ActiveRecord::Migration
  def change
    create_table :tic_tac_toe_games do |t|
      t.belongs_to :x_user
      t.belongs_to :y_user
      t.belongs_to :user_turn
      t.belongs_to :winners
      t.timestamps
    end
  end
end
