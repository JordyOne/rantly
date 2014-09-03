module Api
  class RantsController < ApplicationController
    def index
      rants = Rant.all
      render json: rants
    end
  end
end
