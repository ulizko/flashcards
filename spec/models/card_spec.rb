require "rails_helper"

RSpec.describe Card, type: :model do
  let(:card) { build(:card) }

  describe '#set_review_date' do
    it 'review_date should be nil' do
      expect(card.review_date).to be_nil
    end
    it 'review_date should be not nil' do
      card.save
      expect(card.review_date.beginning_of_hour).to eq(Time.now.beginning_of_hour)
    end
  end

  describe '#check_card' do
    it { expect(card.check_card('car')).to be_truthy }
  end

  describe '#increase_review_date!' do
    it 'should increase review date' do
      card.save
      3.times { card.increase_review_date! }
      expect(card.review_date.beginning_of_hour).to eq(Time.now.beginning_of_hour + 1.week)
    end
  end

  describe '#decrease_review_date!' do
    it 'should decrease review date' do
      card.save
      3.times { card.increase_review_date! }
      3.times { card.decrease_review_date! }
      expect(card.review_date.beginning_of_hour).to eq(Time.now.beginning_of_hour + 12.hour)
    end
  end
end
