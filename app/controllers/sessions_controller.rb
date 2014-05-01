class SessionsController < ApplicationController

 def new 
 end

 def create 
  user = User.find_by_username(params[:username])
  if user && user.authenticate(params[:password])
   session[:user_id] = user.id
   redirect_to root_path, notice: "logged in!"
  else
   flash.now.alert = "username and/or password not found."
   render "new"
  end
 end

 def destroy
  session[:user_id] = nil
  redirect_to root_path, notice: "logged out!"
 end

end
