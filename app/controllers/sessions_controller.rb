class SessionsController < ApplicationController
  skip_before_action :ensure_current_user

  def new
    @user = User.new
  end

  def create
    @user = current_user
    if current_user && current_user.authenticate(allowed_parameters[:password])
      p session_id
      flash[:notice] = "You are signed in"
      redirect_to root_path
    end
  end

  def destroy
    session.destroy
    redirect_to new_session_path
  end

  private

  def current_user
    @user = User.find_by(username: allowed_parameters[:username])
  end

  def allowed_parameters
    params.require(:user).permit(:username, :password)
  end

  def session_id
    session[:user_id] = current_user[:id]
  end
end