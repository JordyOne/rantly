class FavoritesController < ApplicationController
  def create
    if Favorite.find_by(allowed_params) == nil
      if @favorite.valid?
        flash[:notice] = "You just favorited one of #{Rant.find_by(id: allowed_params[:rant_id]).user.first_name}'s rants!!'"
        redirect_to user_path(allowed_params[:user_id])
      else
        redirect_to :back
      end
    end
  end

  private

  def allowed_params
    user_id = params.require(:user_id)
    rant_id = params.require(:rant_id)
    {user_id: user_id, rant_id: rant_id}
  end
end