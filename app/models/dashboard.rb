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

  def current_rant
    Rant.find_by(id: @rant.id)
  end

  def latest_rants
    Rant.where.not(user_id: @user.id).order(:updated_at).reverse[0...10]
  end

  def user_rants
    @user.rants.reverse
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

  def profile_favorite_sorted_rants
    Rant.where(user_id: profile_user.id).sort_by { |rant| -Favorite.where(rant_id: rant.id).count }
  end

  def user_favorites
    Favorite.where(user_id: user.id).sort_by { |favorite| -Favorite.where(rant_id: favorite.rant_id).count }
  end

  def mentioned_rants
    Rant.where('text LIKE ?', "%@"+"#{@user.username}"+"%")
  end
end