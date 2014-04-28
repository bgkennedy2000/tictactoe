class TicTacToeGame < ActiveRecord::Base
  attr_accessible :user_turn_id, :winner_id, :x_user_id, :y_user_id
  belongs_to :x_user, class_name: "User"
  belongs_to :y_user, class_name: "User"
  belongs_to :user_turn, class_name: "User"
  belongs_to :winner, class_name: "User"
  has_many :ttt_moves

 def change_player_turn
  x_user = self.x_user
  y_user = self.y_user
  just_played_user = self.user_turn
  case just_played_user
    when x_user
      self.update_attributes(user_turn_id: self.y_user.id) 
    when y_user
      self.update_attributes(user_turn_id: self.x_user.id) 
  end
 end

 def continue?
  if self.winner_id == nil
    true
  else
    false
  end
 end

 def game_over? 
  if self.winner_id
    true
  else
    false
  end
 end

 def compile_current_user_moves
  user = self.user_turn
  moves = self.ttt_moves.where(user_id:"#{user.id}")
  moves.collect do |move|
    [move.x_coordinate, move.y_coordinate]
  end
 end

 def check_for_winner
  @current_user_moves = self.compile_current_user_moves
  @winners = winning_combinations
  @winners.collect do |winner| 
    if winner & @current_user_moves == winner
      true 
    end
  end
 end

end

  def winning_combinations
 [ [ [1, 1], [2, 1], [3, 1] ],
   [ [1, 2], [2, 2], [3, 2] ],
   [ [1, 3], [2, 3], [3, 3] ],
   [ [1, 1], [1, 2], [1, 3] ],
   [ [2, 1], [2, 2], [2, 3] ],
   [ [3, 1], [3, 2], [3, 3] ],
   [ [1, 1], [2, 2], [3, 3] ],
   [ [3, 1], [2, 2], [1, 3] ] ]
  end
