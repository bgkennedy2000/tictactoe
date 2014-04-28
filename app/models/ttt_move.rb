class TttMove < ActiveRecord::Base
  attr_accessible :tic_tac_toe_game_id, :user_id, :x_coordinate, :y_coordinate
  belongs_to :tic_tac_toe_game
  belongs_to :user
end
