class TicTacToeGamesController < ApplicationController
  def index
  @games = TicTacToeGame.all
  end

  def new
    @game = TicTacToeGame.new
    @users = User.all
  end

  def create
    opponent = User.find_by_username(params[:username])
    if opponent.nil? 
      # build test in case same username or make username unique
      @users = User.all
      render 'new', notice: "Username not found"
    else

    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def show
    @game = TicTacToeGame.find(params[:id])
    @moves = @game.ttt_moves
  end
end
