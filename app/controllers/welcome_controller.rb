class WelcomeController < ApplicationController
  def index
    if session[:user_id]
      redirect_to dashboard_path(current_user)
    else
      render :index
    end
    flash[:register_message] = 'Welcome Back, Please Consider Registering to Begin Your Ranting!'
  end
end