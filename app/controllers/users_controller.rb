class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(allowed_params) #added bang and relied on object for if statement vs. .save function
    if @user.persisted?
      login_user
    else
      render :new
    end
  end

  def show
    current_user
    @rants = sorted_rants
    @rant = Rant.new # initialized Rant for form_for
    @relationship = Relationship.new
  end

  def edit
    current_user
  end

  def update
    if current_user.update_attributes(user_params)
      flash[:notice] = "Profile Updated"
      redirect_to user_path(@user.id)
    else
      flash[:notice] = "Your profile could not be saved"
    end
  end

  def following
    current_user
  end

  def followers
    current_user
  end

  private

  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_params
    params.require(:user).permit(:username, :first_name, :last_name, :bio, :frequency)
  end

  def allowed_params
    params.require(:user).permit(:username, :password, :first_name, :last_name, :bio, :frequency)
  end

  def sorted_rants
    Rant.where.not(user_id: session[:user_id]).order(:updated_at).reverse
  end

  def login_user
    flash[:notice] = "Thank you for registering"
    session[:user_id] = @user.id
    redirect_to user_path(session[:user_id])
  end
end