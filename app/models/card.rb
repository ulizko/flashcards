class Card < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :deck
  belongs_to :user

  scope :review, -> { where('review_date <= ?', Time.now) }
  scope :random_card, -> { order('RANDOM()').take }
  scope :is_not_viewed?, -> { order(:review_date).first.review_date <= Time.now }

  validates_presence_of :original_text, :translated_text, :deck, :user
  validate :original_text_eql_translated_text, on: [:create, :update]
  validates :original_text,
            format: { with: /\A[A-ZА-ЯЁa-zа-яё][a-zа-яё]+\Z/,
                      message: :invalid }
  validates :translated_text,
            format: { with: /\A[А-ЯЁA-Z(а-яёa-z][\s;()-.а-яёa-z]+\Z/,
                      message: :invalid }

  before_create :set_review_date

  def set_review_date
    self.review_date = Time.now
  end

  def update_review_date!(result = {})
    result = if result[:quality] == 3
               result.except!(:interval, :repeat)
             else
               review_date = Time.now + result[:interval].days
               result.merge(review_date: review_date)
             end
    update_attributes(result)
  end

  private

  def original_text_eql_translated_text
    errors.add(:original_text, 'need not be equal to translated text') if
      original_text.downcase == translated_text.downcase
  end
end
