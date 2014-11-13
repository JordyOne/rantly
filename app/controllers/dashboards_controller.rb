class DashboardsController < ApplicationController
  def show
    @dashboard = Dashboard.new(current_user)
  end

  private

  def sorted_rants
    Rant.where.not(user_id: current_user.id).order(:updated_at).reverse
  end
end