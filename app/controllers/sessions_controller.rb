class SessionsController < ApplicationController
  skip_before_action :ensure_current_user

  def new
    @user = User.new
  end

  def create
    @user = current_user
    if @user && @user.authenticate(allowed_parameters[:password])
      sign_in_user
    else
      flash[:notice] = "Your Username / Password combination did not work"
      redirect_to new_session_path
    end
  end

  def show
    @user = User.find_by(current_user)
  end

  def destroy
    session.destroy
    redirect_to new_session_path
  end

  private

  def current_user
    User.find_by(username: allowed_parameters[:username])
  end

  def sign_in_user
    session[:user_id] = @user.id
    flash[:notice] = "You are signed in"
    redirect_to dashboard_path(current_user)
  end

  def allowed_parameters
    params.require(:user).permit(:username, :password)
  end

end