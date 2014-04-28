class User < ActiveRecord::Base
  attr_accessible :draws, :losses, :password_digest, :username, :wins
  has_many :tic_tac_toe_games_x_users, class_name: "TicTacToeGame", foreign_key: "x_user_id" 
  has_many :tic_tac_toe_games_y_users, class_name: "TicTacToeGame", foreign_key: "y_user_id"
  has_many :tic_tac_toe_game_winners, class_name: "TicTacToeGame", foreign_key: "winner_id"
  has_many :tic_tac_toe_game_user_turns, class_name: "TicTacToeGame", foreign_key: "user_turn_id"
  has_many :ttt_moves
end
