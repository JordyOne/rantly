class Favorite < ActiveRecord::Base
    belongs_to :user

    validates :user_id, :rant_id, presence: true
end