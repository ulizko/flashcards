class User < ActiveRecord::Base
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  has_many :authentications, dependent: :destroy
  has_many :decks
  has_many :cards
  accepts_nested_attributes_for :authentications

  delegate :not_reviewed, to: :decks, prefix: true

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true, email_format: { message: 'has invalid format' }

  def self.notify_not_viewed_cards
    select { |v| v.cards.review.present? }.each do |user|
      NotificationsMailer.pending_cards(user)
    end
  end
end
