class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:danger] = 'You must be logged in to perform that action'
      redirect_to root_path
    end
  end

  def validate_user(user_id)
    if session[:user_id] != user_id
      flash[:danger] = 'You are not the proper user to perform this action'
      redirect_to root_path
    end
  end
end
