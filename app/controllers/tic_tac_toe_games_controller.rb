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
      flash[:notice] = "Username not found"
      render :new 
    else
    first_turn = [session[:user_id], opponent.id].shuffle
    @game = TicTacToeGame.create(x_user_id: session[:user_id], y_user_id: opponent.id, user_turn_id: first_turn[0])
    redirect_to tic_tac_toe_game_path(@game.id)
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
