class TicTacToeGame < ActiveRecord::Base
  attr_accessible :user_turn_id, :winner_id, :x_user_id, :y_user_id
  attr_accessor :game_message
  belongs_to :x_user, class_name: "User"
  belongs_to :y_user, class_name: "User"
  belongs_to :user_turn, class_name: "User"
  belongs_to :winner, class_name: "User"
  has_many :ttt_moves

  validates :user_turn_id, presence: true
  validates :x_user_id, presence: true
  validates :y_user_id, presence: { message: "not found. Please provide a valid username" }

  validate :play_yourself?

    # get all the users games in reverse chronological order
  scope :user_games, lambda { |user_id| where(["x_user_id = ? or y_user_id = ?", "#{user_id}", "#{user_id}" ]).order('created_at DESC') }

  def play_yourself?
    if self.x_user_id == self.y_user_id
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
    !game_over?
  end

  def game_over?
    game_has_been_won? || game_has_been_drawn?
  end

  def game_has_been_won?
    !!self.winner_id
  end

  def game_has_been_drawn?
    played_moves.size == 9 && !game_has_been_won?
  end

 def compile_current_user_moves
  user = self.user_turn
  moves = self.ttt_moves.where(user_id:"#{user.id}")
  moves.collect do |move|
    [move.x_coordinate, move.y_coordinate]
  end
 end

 def check_for_winner_or_draw
  @current_user_moves = self.compile_current_user_moves
  @winners = winning_combinations
  temp = @winners.collect do |winner| 
    if winner & @current_user_moves == winner
      true 
    end
  end
  if temp.include? true
    self.declare_winner
  elsif game_has_been_drawn?
    self.declare_draw
  end
 end

 def declare_winner
  self.winner = self.user_turn
  self.game_message = "#{self.winner.username} is the winner!"
  self.save
 end

 def declare_draw
  self.game_message = "Game over! Its a draw!"
  self.save
 end

 def self.recent_games(user_id)
  games = { }
  if user_id
    user = User.find(user_id)
    users_games = user.tic_tac_toe_games_in_process
    user.opponents_hash(users_games, number: 3)
  else
    { }
  end
 end

 def self.games_count(user_id)
  if user_id
    user = User.find(user_id)
    user.tic_tac_toe_games_in_process.count
  else
    0
  end
 end

 def played_moves
  self.ttt_moves.collect do |move|
        [ move.x_coordinate, move.y_coordinate ]
    end
  end

  def x_or_o_next?(xhtml, ohtml)
    if self.user_turn == self.x_user
      xhtml
    elsif self.user_turn == self.y_user
      ohtml
    else
      raise "Game doesn't know who's turn it is"
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

  def all_moves
    [ [1, 1], [2, 1], [3, 1],
      [1, 2], [2, 2], [3, 2],
      [1, 3], [2, 3], [3, 3], ]
  end

