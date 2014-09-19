class RantsController < ApplicationController
  def index
    @rants = Rant.find_by(user_id: params[:user_id])
  end

  def create
    @rant = Rant.create!(allowed_parameters)
    redirect_to user_path(allowed_parameters[:user_id])
  end

  private

  def allowed_parameters
    params.require(:rant).permit(:title, :text).merge({:user_id => params[:user_id]})
  end
end