class RantsController < ApplicationController

  def create
    @rant = Rant.create(allowed_parameters)
    if @rant.valid?
      render json: @rant
    end
  end

  def destroy
    @rant = find_rant

    if @rant.user_id == current_user.id
      @rant.destroy
      flash[:notice] = 'rant deleted!'
    else
      flash[:notice] = 'you can only delete your own rants!'
    end

    redirect_to dashboard_path(current_user)
  end

  def show
    @dashboard = Dashboard.new(current_user, rant_user, find_rant)
  end

  def spam
    Spam.create(user_id: allowed_parameters[:user_id], rant_id: allowed_parameters[:rant_id])
    flash[:message] = "Rant reported as spam."

    redirect_to user_rant_path(current_user, find_rant.id)
  end

  def unspam
    Spam.find_by(user_id: allowed_parameters[:user_id], rant_id: allowed_parameters[:rant_id]).destroy

    redirect_to user_rant_path(current_user, find_rant.id)
  end

  private

  def rant_user
    rant = Rant.find_by(id: allowed_parameters[:rant_id])
    User.find_by(id: rant.user.id)
  end

  def find_rant
    Rant.find_by(id: allowed_parameters[:rant_id])
  end

  def allowed_parameters
    if params[:rant]
      params.require(:rant).permit(:text, :title, :search_term).merge(user_id: params[:user_id])
    else
      user_id = params[:user_id]
      id = params[:id]
      {user_id: user_id, rant_id: id}
    end
  end

end