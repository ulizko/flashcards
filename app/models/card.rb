class Card < ActiveRecord::Base
  scope :review, -> { where('review_date <= current_date') }
  scope :random_card, -> { order('RANDOM()').take }

  validates_presence_of :original_text, :translated_text
  validate :original_text_eql_translated_text, on: :create
  validates :original_text,
            format: {
              with: /\A[A-Za-z][a-z]+\Z/,
              message: ' should contain only the English alphabet and can\'t ' \
              'contain spaces in start of string' }
  validates :translated_text,
            format: {
              with: /\A[А-ЯЁ(а-яё][\s;()-.а-яё]+\Z/,
              message: ' should contain only the Cyrillic alphabet and can\'t ' \
              'contain spaces in start of string' }

  before_create :set_review_date, if: 'review_date.nil?'

  def set_review_date
    self.review_date = Date.today + 3
  end

  def check_card(check_translate)
    original_text.downcase == check_translate.strip.downcase
  end

  def increase_review_date!
    update_attributes(review_date: Date.today.days_since(3))
  end

  private

  def original_text_eql_translated_text
    errors.add(:original_text, 'need not be equal to translated text') if
      original_text.downcase == translated_text.downcase
  end
end
