class RantsController < ApplicationController
  def index
    @rants = Rant.find_by(allowed_parameters)
  end

  def create
    @rant = Rant.create(allowed_parameters)
    if @rant.persisted?
      redirect_to user_path(allowed_parameters[:user_id])
    end
  end

  def destroy
    Rant.find_by(id: params[:id]).destroy
    redirect_to user_path(params[:user_id])
  end

  private

  def allowed_parameters
    params.require(:rant).permit(:title, :text).merge({:user_id => params[:user_id]})
  end
end