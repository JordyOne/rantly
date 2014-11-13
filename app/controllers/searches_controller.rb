class SearchesController < ApplicationController
  def index
    @rants = find_rants_by_last_name

    render json: @rants
  end

  def show
  end

  private

  def find_rants_by_last_name
    Rant.joins(:user).where(users: {last_name: allowed_parameters[:search_term]})
  end

  def allowed_parameters
    params.require(:search).permit(:search_term)
  end

end