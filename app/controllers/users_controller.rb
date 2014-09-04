class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    #left off createing users for the users table
  end
end