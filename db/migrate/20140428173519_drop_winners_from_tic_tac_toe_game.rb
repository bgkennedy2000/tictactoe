class DropWinnersFromTicTacToeGame < ActiveRecord::Migration
 def up
    remove_column :tic_tac_toe_games, :winners_id
  end

  def down
    add_column :tic_tac_toe_games, :winners_id, :integer
  end
end
