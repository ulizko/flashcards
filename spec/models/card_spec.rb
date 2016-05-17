require "rails_helper"

RSpec.describe Card, type: :model do
  let(:card) { FactoryGirl.build(:card) }

  describe '#set_review_date' do
    it 'review_date should be nil' do
      expect(card.review_date).to be_nil
    end
    it 'review_date should be not nil' do
      card.save
      expect(card.review_date).to eq(Date.today + 3)
    end
  end

  describe '#check_card' do
    it { expect(card.check_card('car')).to be_truthy }
  end

  describe '#increase_review_date!' do
    it 'should increase review date' do
      card.review_date = Date.today - 1
      card.increase_review_date!
      expect(card.review_date).to eq(Date.today + 3)
    end
  end
end
