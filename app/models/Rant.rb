class Rant < ActiveRecord::Base
  belongs_to :user
  has_many   :favorites, dependent: :destroy

  validates :title, :text, presence: true
  validates :title, length: {maximum: 50}
  validates :text,  length: {minimum: 140}


end