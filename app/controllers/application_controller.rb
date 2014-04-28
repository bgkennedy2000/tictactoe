class ApplicationController < ActionController::Base
  protect_from_forgery

def index
  @games = TicTacToeGame.games(session[:user_id])
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

end
