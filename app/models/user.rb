class User < ActiveRecord::Base
  has_secure_password
  has_many :rants, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name: "Relationship",
                                   dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_attached_file :avatar, styles: {
      thumb: '100x100>',
      square: '200x200#',
      medium: '300x300>'
  }

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  validates :username, :password_digest, :first_name, :last_name, :bio, :frequency, presence: true


  def following?(other_user)
    self.relationships.find_by(followed_id: other_user.id)
  end

  def favorite?(rant_id)
    self.favorites.find_by(rant_id: rant_id)
  end

end