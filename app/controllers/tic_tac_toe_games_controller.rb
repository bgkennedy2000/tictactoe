class TicTacToeGamesController < ApplicationController
  def index
  @games = TicTacToeGame.all
  end

  def new
    @game_type = params[:game_type] 
    case @game_type
      when "dual"
        @game = TicTacToeGame.new
        @users = User.all
      when "single"
        create
    end

  end

  def create
    @move = TttMove.new
    @game_type ||= "dual"
    case @game_type
      when "dual"
        @opponent = User.find_by_username(params[:username])
        first_turn = [session[:user_id], @opponent.try(:id)].shuffle
        @game = TicTacToeGame.new(x_user_id: session[:user_id], y_user_id: @opponent.try(:id), user_turn_id: first_turn[0])
        if @game.save 
          redirect_to tic_tac_toe_game_path(@game.id)
        else
          @users = User.all
          render :new
        end
      when "single" # create game with user id 12, which is "computer" username, as opponent 
        @computer = set_computer_user
        first_turn = [session[:user_id], @computer.id ].shuffle
        @game = TicTacToeGame.new(x_user_id: session[:user_id], y_user_id: @computer.id, user_turn_id: session[:user_id])
        @game.save
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
    @move = TttMove.new
  end
end
