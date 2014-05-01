class TttMovesController < ApplicationController
load_and_authorize_resource

  def create
    @computer = set_computer_user
    @game = TicTacToeGame.find(params[:tic_tac_toe_game_id])
    @move = @game.ttt_moves.build(user_id: current_user.id, x_coordinate: params[:x_coord], y_coordinate: params[:y_coord])
    unless @move.invalid_move? 
      render('/tic_tac_toe_games/show', notice: "Invalid move") and return
    end
    if @game.check_for_winner_or_draw
      render('/tic_tac_toe_games/show', notice: "#{@game.game_message}") and return
    else
      @game.change_player_turn
    end
    if @game.y_user == @computer
      TttMove.do_computer_move(@game)
      if @game.check_for_winner_or_draw
        redirect_to tic_tac_toe_game_path(@game.id), notice: "#{@game.game_message}"
      else
        @game.change_player_turn
        redirect_to tic_tac_toe_game_path(@game.id)
      end
    else
      redirect_to tic_tac_toe_game_path(@game.id)
    end   
  end


end
