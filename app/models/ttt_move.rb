class TttMove < ActiveRecord::Base
  attr_accessible :tic_tac_toe_game_id, :user_id, :x_coordinate, :y_coordinate
  belongs_to :tic_tac_toe_game
  belongs_to :user

  validates :tic_tac_toe_game_id, presence: true
  validates :user_id, presence: true
  validates :x_coordinate, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 3 }
  validates :y_coordinate, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 3 }

  validate :users_turn?
  validate :square_available? 

  def square_available? 
    move_to_check = [self.x_coordinate, self.y_coordinate]
    if self.tic_tac_toe_game.played_moves.include?(move_to_check)
      errors.add(:move_location, "That square you have chosen is not available.  Try again.")
    end
  end

  def users_turn?
    if self.tic_tac_toe_game.user_turn_id != self.user_id
      errors.add(:user_id, "Move's user must match the game's user turn")
    end
  end


  def invalid_move?
    self.save
  end

  def self.do_computer_move(game)
    available_moves = all_moves
    xy = opposite_of_intersect(game.played_moves, available_moves).shuffle[0]
    move = game.ttt_moves.build(user_id: game.y_user_id, x_coordinate: xy[0], y_coordinate: xy[1])
    raise "Error processing computer's move.  Sorry!" unless move.save
  end

  def make_x_or_o?(xhtml, ohtml)
    if self.user_id == self.tic_tac_toe_game.x_user_id
      xhtml
    elsif self.user_id == self.tic_tac_toe_game.y_user_id 
      ohtml
    else
      raise 'Cannot determine if player is X or O'
    end
  end  

end

  def all_moves
    [ [1, 1], [2, 1], [3, 1],
      [1, 2], [2, 2], [3, 2],
      [1, 3], [2, 3], [3, 3], ]
  end

  def opposite_of_intersect(ar_1, ar_2)
    (ar_1 + ar_2) - (ar_1 & ar_2) 
  end
