class User < ActiveRecord::Base
  attr_accessible :draws, :losses, :password, :username, :wins, :password_confirmation  
  has_many :tic_tac_toe_games_x_users, class_name: "TicTacToeGame", foreign_key: "x_user_id" 
  has_many :tic_tac_toe_games_y_users, class_name: "TicTacToeGame", foreign_key: "y_user_id"
  has_many :tic_tac_toe_game_winners, class_name: "TicTacToeGame", foreign_key: "winner_id"
  has_many :tic_tac_toe_game_user_turns, class_name: "TicTacToeGame", foreign_key: "user_turn_id"
  has_many :ttt_moves

  has_secure_password
  validates :username, uniqueness: { message: "Sorry.  That username is already taken.  Please choose another username."}
end
