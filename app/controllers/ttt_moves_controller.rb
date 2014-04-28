class TttMovesController < ApplicationController
  def index
  end

  def new
 
  end

  def create
    @game = TicTacToeGame.find(params[:tic_tac_toe_game_id])
    @move = TttMove.create(tic_tac_toe_game_id: @game.id, user_id: @game.user_turn.id, x_coordinate: params[:x_coord], y_coordinate: params[:y_coord])
    if @game.check_for_winner.include?(true)
      @game.update_attributes(winner_id: @game.user_turn.id)
      redirect_to tic_tac_toe_game_path(@game.id), notice: "You Win!"
    else
    @game.change_player_turn
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
  end
end
