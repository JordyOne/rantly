class Dashboard
  def initialize(user, profile_user=nil, rant=nil)
    @user = user
    @rant = rant
    @profile_user = profile_user
  end

  def user
    @user
  end

  def profile_user
    @profile_user
  end

  def new_rant
    Rant.new
  end

  def latest_rants
    Rant.where.not(user_id: @user.id)
  end

  def user_rants
    @user.rants
  end

  def profile_user_rants
    @profile_user.rants
  end

  def current_rant_text
    @rant.text
  end

  def current_rant_title
    @rant.title
  end
end