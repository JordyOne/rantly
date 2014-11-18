class ProfilesController < ApplicationController
  def show
    @dashboard = Dashboard.new(current_user, profile_user, rant)
  end

  private

  def profile_user
    User.find_by(id: allowed_parameters[:profile_user_id])
  end

  def current_user
    User.find_by(id: allowed_parameters[:user_id])
  end

  def rant
    if allowed_parameters[:profile_user]
      Rant.find_by(id: allowed_parameters[:id])
    else
      nil
    end
  end

  def sorted_rants
    Rant.where.not(user_id: @user.id).order(:updated_at).reverse
  end

  def allowed_parameters
    if params[:profile_id]
      user_id = params.require(:user_id)
      profile_user_id = params.require(:profile_id)
      rant_id = params.require(:id)
      {user_id: user_id, profile_user_id: profile_user_id, rant_id: rant_id}
    else
      user_id = params.require(:user_id)
      profile_user_id = params.require(:id)
      {user_id: user_id, profile_user_id: profile_user_id}
    end
  end
end