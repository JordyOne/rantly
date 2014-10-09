class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(allowed_params)
    if @user.save
      flash[:notice] = "Thank you for registering"
      session[:user_id] = @user.id
      redirect_to user_path(session[:user_id])
    else
      render :new
    end
  end

  def show
    @user = User.find_by(id: session[:user_id])
    @rants = Rant.where(:user_id != session[:user_id])
    @rant = Rant.new # initialized Rant for form_for
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update_attributes!(user_params)
      flash[:notice] = "Profile Updated"
      redirect_to user_path(@user.id)
    else
      flash[:notice] = "Your profile could not be saved"
    end
  end

  def following
    @user = User.find_by(id: session[:user_id])
  end

  private

  def user_params
    params.require(:user).permit(:username, :first_name, :last_name, :bio, :frequency)
  end

  def allowed_params
    params.require(:user).permit(:username, :password, :first_name, :last_name, :bio, :frequency)
  end
end