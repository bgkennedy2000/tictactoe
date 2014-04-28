class AddWinnerIdToTicTacToeGame < ActiveRecord::Migration
  def up
    add_column :tic_tac_toe_games, :winner_id, :integer
  end

  def down
    remove_column :tic_tac_toe_games, :winner_id
  end
end
