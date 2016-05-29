class Deck < ActiveRecord::Base
  belongs_to :user
  has_many :cards, dependent: :destroy
  
  scope :current, -> { where('current is true').first }
end