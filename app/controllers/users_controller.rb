class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(allowed_params)
    if @user.valid?
      login_user
    else
      render :new
    end
  end

  def show
    render json: current_user
  end

  def edit
    current_user
  end

  def update
    if current_user.update_attributes(current_user_params)
      flash[:notice] = "Profile Updated"
      redirect_to user_path(current_user)
    else
      flash[:notice] = "Your profile could not be saved"
    end
  end

  def following
    @dashboard = Dashboard.new(current_user)
  end

  def followers
    current_user
  end

  private

  def current_user_params
    params.require(:user).permit(:username, :first_name, :last_name, :bio, :frequency)
  end

  def allowed_params
    params.require(:user).permit(:username, :password, :first_name, :last_name, :bio, :frequency)
  end

  def login_user
    flash[:notice] = "Thank you for registering"
    session[:user_id] = @user.id
    redirect_to dashboard_path(current_user)
  end
end