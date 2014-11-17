class FavoritesController < ApplicationController
  def create
    @favorite = Favorite.create!(allowed_params)

    render json: @favorite
  end

  def destroy
    @favorite = Favorite.find_by(allowed_params)
    @favorite.destroy

    render json: @favorite
  end

  private

  def allowed_params
    {user_id: current_user.id, rant_id: params[:id]}
  end
end