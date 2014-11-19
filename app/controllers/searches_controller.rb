class SearchesController < ApplicationController

  def index
    @dashboard = Dashboard.new(current_user)
    if params[:search_term]
      @search = Search.new(params[:search_term])
      @users = Search.new(params[:search_term]).search_user_names
    else
      @search = Search.new
    end
    render :index
  end

  private

  def allowed_parameters
    params.require(:search).permit(:search_term)
  end

end