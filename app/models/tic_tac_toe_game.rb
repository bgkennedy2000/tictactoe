class TicTacToeGame < ActiveRecord::Base
  attr_accessible :user_turn_id, :winner_id, :x_user_id, :y_user_id
  belongs_to :x_user, class_name: "User"
  belongs_to :y_user, class_name: "User"
  belongs_to :user_turn, class_name: "User"
  belongs_to :winner, class_name: "User"
  has_many :ttt_moves

  validates :user_turn_id, presence: true
  validates :x_user_id, presence: true
  validates :y_user_id, presence: true  # add custom message if possible

  validate :play_yourself?

    # get all the users games in reverse chronological order
  scope :user_games, lambda { |user_id| where(["x_user_id = ? or y_user_id = ?", "#{user_id}", "#{user_id}" ]).order('created_at DESC') }

  def play_yourself?
    if self.x_user == self.y_user
      errors.add(:user_error, "A player cannot play him/herself. That would be stupid.")
    end

  end

 def change_player_turn
  x_user = self.x_user
  y_user = self.y_user
  just_played_user = self.user_turn
  case just_played_user
    when x_user
      self.update_attributes(user_turn_id: self.y_user_id) 
    when y_user
      self.update_attributes(user_turn_id: self.x_user_id) 
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
  temp = @winners.collect do |winner| 
    if winner & @current_user_moves == winner
      true 
    end
  end
  if temp.include? true
    self.declare_winner
  else
    nil
  end
 end

 def declare_winner
  self.winner = self.user_turn
  self.save
  self.winner
 end

 def self.recent_games(user_id)
  games = { }
  if user_id
    temp = self.user_games(user_id)
    temp.each do |game|
      # create a hash with the the opponent as key and the game as the value, add gameID to key to prevent overwriting games w/ same opponents
      if game.y_user_id == user_id && game.continue?
        games[ [game.x_user, game.id] ] = game
      end
      if game.x_user_id == user_id && game.continue?
        games[ [ game.y_user, game.id ] ] = game
      end
    end
    return games.first(3)
  else
    { }
  end
 end

 def played_moves
  self.ttt_moves.collect do |move|
        [ move.x_coordinate, move.y_coordinate ]
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
