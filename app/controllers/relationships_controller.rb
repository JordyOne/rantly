class RelationshipsController < ApplicationController
  def create
    @relationship = Relationship.create!(allowed_params)

    render json: @relationship
  end

  def destroy
    @relationship = Relationship.find_by(allowed_params)
    @relationship.destroy

    render json: @relationship
  end

  private

  def allowed_params
    if params[:relationship]
      params.require(:relationship).permit(:followed_id, :follower_id)
    end
  end
end