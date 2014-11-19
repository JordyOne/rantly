class Spam < ActiveRecord::Base
  belongs_to :user
  belongs_to :rant

  validates :user_id, :rant_id, presence: true


end