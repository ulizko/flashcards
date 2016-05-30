class Deck < ActiveRecord::Base
  belongs_to :user
  has_many :cards, dependent: :destroy

  scope :current, -> { where(current: true) }

  validates_presence_of :name

  before_update :set_current_deck

  def set_current_deck
    Deck.update_all(current: false)
    self.current = true
  end
end
