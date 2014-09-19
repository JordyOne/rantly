module UserHelper

  def full_name(user)
    [user.first_name.capitalize, user.last_name.capitalize].join(" ")
  end

end