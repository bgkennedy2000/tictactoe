 module ApplicationHelper

  def board_move(game, x_coord, y_coord)
    move = game.ttt_moves.select do |move| move.x_coordinate == x_coord && move.y_coordinate == y_coord end
    if move.any?
      move[0].make_x_or_o?(image_tag('circle-x-8x.png', class: "x-play"), image_tag('media-record-8x.png', class: "o-play"))
    elsif game.continue? && session[:user_id] == game.user_turn_id
      link_to image_tag(game.x_or_o_next?('circle-x-8x.png', 'media-record-8x.png'), class: "next-play #{game.x_or_o_next?('x-play', 'o-play')}"), create_tic_tac_toe_game_ttt_move_path(game.id, x_coord: "#{x_coord}", y_coord: "#{y_coord}"), method: :post
    else
      " "
    end
  end


end
