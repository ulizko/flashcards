class Card < ActiveRecord::Base
  DATE = [0, 12.hour, 3.day, 1.week, 2.week, 1.month].freeze

  mount_uploader :image, ImageUploader

  belongs_to :deck
  belongs_to :user

  scope :review, -> { where('review_date <= ?', Time.now) }
  scope :random_card, -> { order('RANDOM()').take }

  validates_presence_of :original_text, :translated_text, :deck, :user
  validate :original_text_eql_translated_text, on: [:create, :update]
  validates :original_text,
            format: { with: /\A[A-Za-z][a-z]+\Z/,
                      message: ' should contain only the English alphabet and ' \
                        'can\'t contain spaces in start of string' }
  validates :translated_text,
            format: { with: /\A[А-ЯЁ(а-яё][\s;()-.а-яё]+\Z/,
                      message: ' should contain only the Cyrillic alphabet and ' \
                        'can\'t contain spaces in start of string' }

  before_create :set_review_date

  def set_review_date
    self.review_date = Time.now
  end

  def increase_review_date!
    update_attributes(try: tries, mistake: 0, review_date: Time.now + DATE[tries])
  end

  def decrease_review_date!
    if full_mistake?
      update_attributes(try: try, mistake: mistake.next, review_date: review_date)
    else
      update_attributes(try: 1, mistake: 0, review_date: Time.now + DATE[1])
    end
  end

  def check_card?(check_translate)
    original_text.downcase == check_translate.strip.downcase
  end

  def short_distance?(check_translate)
    DamerauLevenshtein.distance(original_text.downcase,
                                check_translate.strip.downcase) <= 2
  end

  private

  def original_text_eql_translated_text
    errors.add(:original_text, 'need not be equal to translated text') if
      original_text.downcase == translated_text.downcase
  end

  def full_mistake?
    mistake < 2
  end

  def tries
    try <= 5 ? try.next : try
  end
end
