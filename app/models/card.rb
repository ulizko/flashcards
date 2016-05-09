class Card < ActiveRecord::Base

  validates_presence_of :original_text, :translated_text
  validates_uniqueness_of :original_text, :translated_text
  validate :original_text_eql_translated_text
  validates :original_text, format: { with: /\A[A-Za-z][a-z]+\Z/,
    message: ' should contain only the English alphabet and can\'t contain spaces in start of string' }
  validates :translated_text, format: { with: /\A[А-Яа-я][а-я]+\Z/, 
    message: ' should contain only the Cyrillic alphabet and can\'t contain spaces in start of string' }
  validates :review_date, presence: true

  before_validation :set_review_date

  private

  def set_review_date
    self.update_attribute(:review_date, Time.now + 3 * 60 * 60 * 24)
  end

  def original_text_eql_translated_text
    errors.add(:original_text, 'need not be equal to translated text') if
      original_text.downcase == translated_text.downcase
  end
end
