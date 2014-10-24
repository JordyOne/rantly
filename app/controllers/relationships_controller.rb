class RelationshipsController < ApplicationController
  def create
    if Relationship.find_by(allowed_params) == nil
      @relationship = Relationship.create(allowed_params)
      if @relationship.persisted?
        user = User.find_by(id: allowed_params[:follower_id])
        redirect_to user_path(user)
      end
    else
      following_user = User.find_by(id: allowed_params[:follower_id])
      followed_user = User.find_by(id: allowed_params[:followed_id])
      flash[:notice] = "You are already following #{followed_user.username}."
      redirect_to user_path(following_user)
    end
  end

  def destroy
    Relationship.find_by(follower_id: params[:user_id], followed_id: params[:id]).destroy # I need help configuring this params.  This is a symptom of the formatting.  You need to fix this.
    redirect_to (:back)
  end

  private

  def allowed_params
    user_id = params.require :user_id
    followed_id = params.require :followed_id
    {follower_id: user_id, followed_id: followed_id}
  end

  # I could not get the parameters to format correctly in my form_for in _latest_rants, so I came up with this solution just to move on.
end