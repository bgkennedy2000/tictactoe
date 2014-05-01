class User < ActiveRecord::Base
  attr_accessible :draws, :losses, :password, :username, :wins, :password_confirmation, :role  
  has_many :tic_tac_toe_games_x_users, class_name: "TicTacToeGame", foreign_key: "x_user_id" 
  has_many :tic_tac_toe_games_y_users, class_name: "TicTacToeGame", foreign_key: "y_user_id"
  has_many :tic_tac_toe_game_winners, class_name: "TicTacToeGame", foreign_key: "winner_id"
  has_many :tic_tac_toe_game_user_turns, class_name: "TicTacToeGame", foreign_key: "user_turn_id"
  has_many :ttt_moves

  has_secure_password
  validates :username, uniqueness: { message: "is already taken.  Please choose another username."}

  def self.guest_user
    self.new(role: "guest")
  end

  def role?(role)
    self.role.to_s == role.to_s
  end

  def tic_tac_toe_games
    (self.tic_tac_toe_games_x_users + self.tic_tac_toe_games_y_users).sort! { |a,b| b.created_at <=> a.created_at }
  end

  def tic_tac_toe_games_won
    self.tic_tac_toe_games.select! { |game| self.game_outcome(game) == 'won'}
  end

  def tic_tac_toe_games_lost
    self.tic_tac_toe_games.select! { |game| self.game_outcome(game) == 'lost' }
  end

  def tic_tac_toe_games_drawn
    self.tic_tac_toe_games.select! { |game| self.game_outcome(game) == 'draw' }
  end

  def tic_tac_toe_games_in_process
    self.tic_tac_toe_games.select! { |game| self.game_outcome(game) == "in process..." }
  end



  def opponent(game)
    if game.y_user == self
      game.x_user 
    elsif game.x_user == self
      game.y_user 
    else
      raise 'cannot find opponent'
    end
  end

  def game_outcome(game)
    if self.id == game.winner_id
      "won"
    elsif game.game_has_been_drawn?
      "draw"
    elsif game.game_has_been_won? && game.winner_id != self.id
      "lost"
    else 
      "in process..."
    end
  end

  def opponents_hash(games_array, options = { })
    games_hash = { }
    games_array.each do |game|
    if game.y_user_id == self.id
      games_hash[ [game.x_user, game.id] ] = game
    end
    if game.x_user_id == self.id
      games_hash[ [ game.y_user, game.id ] ] = game
    end
    end
    if options[:number]
      games_hash.first(options[:number])
    else
      games_hash
    end
  end

  def count_in_process
    self.tic_tac_toe_games_in_process.size
  end

end