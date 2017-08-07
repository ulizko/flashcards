class User < ApplicationRecord
  rolify
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  has_many :authentications, dependent: :destroy
  has_many :decks
  has_many :cards
  accepts_nested_attributes_for :authentications

  before_create :set_default_locale

  delegate :not_reviewed, to: :decks, prefix: true

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/,
                    message: 'has invalid format' }

  def self.notify_not_viewed_cards
    users = select(:email).group('users.email').joins(:cards).where('cards.review_date <= ?', Time.now)
    users.each do |user|
      NotificationsMailer.pending_cards(user).deliver_now
    end
  end

  private

  def set_default_locale
    self.locale = I18n.locale
  end
end
