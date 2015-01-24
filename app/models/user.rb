require 'bcrypt'

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
  has_many :spams

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

  def admin?(session_id)
    User.find_by(id: session_id).admin
  end

  def follow!(followed)
    Relationship.create!(follower_id: self.id, followed_id: followed.id)
  end

  def unfollow!(followed)
    Relationship.find_by(follower_id: self.id, followed_id: followed.id).destroy
  end

  def self.authenticate(username, password)
    if user = find_by_username(username)
      if BCrypt::Password.new(user.password_digest).is_password? password
        return user
      end
    end
  end
end