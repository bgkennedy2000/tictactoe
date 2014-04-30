class UsersController < ApplicationController
 def index
  @users = User.all
 end
 def new
  @user = User.new
 end
 def create 
  @user = User.new(params[:user])
  @user.role = 'user'
  if @user.save
   session[:user_id] = @user.id
   redirect_to root_path, notice: "New user created!"
  else
   render 'new'
  end
 end

 def show
  @user = User.find(current_user.id)
 end


end
