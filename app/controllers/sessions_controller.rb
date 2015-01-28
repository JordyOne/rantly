class SessionsController < ApplicationController
  skip_before_action :ensure_current_user

  def new
    @user = User.new
  end

  def create
    @user = current_user_by_username
    if @user && @user.authenticate(allowed_parameters[:password])
      sign_in_user
    else
      flash[:notice] = "Your Username / Password combination did not work"
      redirect_to new_session_path
    end
  end

  def show
    @user = current_user
  end

  def destroy
    session.destroy
    redirect_to new_session_path
  end

  private

  def current_user_by_username
    User.find_by_username(allowed_params[:username])
  end

  def sign_in_user
    session[:user_id] = @user.id
    flash[:notice] = "You are signed in"
    redirect_to dashboard_path(current_user)
  end

  def allowed_params
    params.require(:user).permit(:username, :password)
  end

end