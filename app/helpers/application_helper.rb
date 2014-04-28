module ApplicationHelper

  def board_move(game, moves, x_coord, y_coord)
    array = moves.select do |move| move.x_coordinate == x_coord && move.y_coordinate == y_coord end
    if array.any?
      array[0].user.try(:username)
    else
      link_to 'Play Here', create_tic_tac_toe_game_ttt_move_path(game.id, x_coord: "#{x_coord}", y_coord: "#{y_coord}"), method: :post
    end
  end

end
