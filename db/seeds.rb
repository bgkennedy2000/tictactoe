# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
TicTacToeGame.delete_all
TttMove.delete_all

User.create(username:"Ben")
User.create(username:"John")
User.create(username:"Mike")

TicTacToeGame.create(x_user_id:1, y_user_id:2, user_turn_id:1)

TttMove.create(tic_tac_toe_game_id:1, user_id:1, x_coordinate:1, y_coordinate:1)
TttMove.create(tic_tac_toe_game_id:1, user_id:2, x_coordinate:3, y_coordinate:3)