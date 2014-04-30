class ApplicationController < ActionController::Base
  protect_from_forgery  

rescue_from CanCan::AccessDenied do |exception|
  redirect_to root_url, :alert => exception.message
end

def index
  @games = TicTacToeGame.recent_games(session[:user_id])
end

helper_method :current_user
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  def logged_in?
    !!current_user
  end
  private
  def authenticate
    unless logged_in?
      flash[:error] = "You must be logged in to access this section of the site"
      redirect_to new_session_path
    end
  end

helper_method :set_computer_user 
  def set_computer_user
    User.find_by_username('Computer')
  end


end
