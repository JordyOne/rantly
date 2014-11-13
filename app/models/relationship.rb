class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  validates :follower_id, presence: true
  validates :followed_id, presence: true
  #
  # def follow!(other_user)
  #   self.create!(followed_id: other_user.id)
  # end
  #
  # def unfollow!(other_user)
  #   self.find_by(followed_id: other_user.id).destroy
  # end
end
