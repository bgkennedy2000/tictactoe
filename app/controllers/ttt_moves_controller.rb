class TttMovesController < ApplicationController
  def index
  end

  def new
 
  end

  def create
    @computer = set_computer_user
    @game = TicTacToeGame.find(params[:tic_tac_toe_game_id])
    @move = @game.ttt_moves.build(user_id: current_user.id, x_coordinate: params[:x_coord], y_coordinate: params[:y_coord])
    @move.record_move
    if @game.check_for_winner
      render('/tic_tac_toe_games/show', notice: "You win!") and return
    else
      @game.change_player_turn
    end
    if @game.y_user == @computer
      TttMove.do_computer_move(@game)
      if @game.check_for_winner
        redirect_to tic_tac_toe_game_path(@game.id), notice: "You lose!"
      else
        @game.change_player_turn
        redirect_to tic_tac_toe_game_path(@game.id), notice: "Your turn!"
      end
    else
      redirect_to tic_tac_toe_game_path(@game.id), notice: "Your turn!"
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
