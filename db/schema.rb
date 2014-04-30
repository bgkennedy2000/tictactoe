# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140430144209) do

  create_table "tic_tac_toe_games", :force => true do |t|
    t.integer  "x_user_id"
    t.integer  "y_user_id"
    t.integer  "user_turn_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "winner_id"
  end

  create_table "ttt_moves", :force => true do |t|
    t.integer  "tic_tac_toe_game_id"
    t.integer  "user_id"
    t.integer  "x_coordinate"
    t.integer  "y_coordinate"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "password_digest"
    t.integer  "wins"
    t.integer  "losses"
    t.integer  "draws"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "role"
  end

end
