class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(allowed_params)
    if @user.save
      flash[:notice] = "Thank you for registering"
      redirect_to sessions_path
    else
      render :new
    end
  end

  private

  def allowed_params
    params.require(:user).permit(:username, :password, :first_name, :last_name, :bio, :frequency)
  end
end