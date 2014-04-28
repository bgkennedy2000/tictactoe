class TicTacToeGamesController < ApplicationController
  def index
  @games = TicTacToeGame.all
  end

  def new
    @game = TicTacToeGame.new
  end

  def create
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
