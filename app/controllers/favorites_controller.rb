class FavoritesController < ApplicationController
  def index
    @dashboard = Dashboard.new(user)
  end

  def create
    @favorite = Favorite.create!(allowed_params)

    render json: @favorite
  end

  def destroy
    @favorite = Favorite.find_by(allowed_params)
    p @favorite
    @favorite.destroy

    render json: @favorite
  end

  private

  def user
    User.find_by(id: allowed_params[:user_id])
  end

  def allowed_params
    {user_id: current_user.id, rant_id: params[:id]}
  end
end