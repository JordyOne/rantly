class Rant < ActiveRecord::Base
  belongs_to :user

  validates :title, :text, presence: true
end