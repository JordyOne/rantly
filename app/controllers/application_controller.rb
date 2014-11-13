class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def ensure_current_user
    redirect_to new_user_path unless current_user
  end

  def current_user
      @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user
end
