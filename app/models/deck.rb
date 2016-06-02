class Deck < ActiveRecord::Base
  belongs_to :user
  has_many :cards, dependent: :destroy

  scope :current, -> { where(current: true).take }
  scope :not_reviewed, -> { current.cards.review }

  validates_presence_of :name

  before_update :set_current_deck

  def set_current_deck
    user.decks.update_all(current: false)
    self.current = true
  end
end
