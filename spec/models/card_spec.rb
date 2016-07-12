require "rails_helper"

RSpec.describe Card, type: :model do
  describe '#set_review_date' do
    let(:card) { build(:card) }

    it 'review_date should be nil' do
      expect(card.review_date).to be_nil
    end
    it 'review_date should be not nil' do
      card.save
      expect(card.review_date.beginning_of_hour).to eq(Time.now.beginning_of_hour)
    end
  end

  context 'checking card' do
    let!(:card) { create(:card) }
    let(:result) { { quality: 4, interval: 1 } }

    describe '#check_card?' do
      it { expect(card.check_card?('car')).to be_truthy }
    end

    describe 'next_review_date' do
      it 'should set next review date at 1 day' do
        card.next_review_date!(result)
        expect(card.review_date.beginning_of_hour).to eq(Time.now.beginning_of_hour + 1.day)
      end

      it 'should set next review date at 2 days' do
        result[:interval] = 2
        card.next_review_date!(result)
        expect(card.review_date.beginning_of_hour).to eq(Time.now.beginning_of_hour + 2.days)
      end

      it 'should set next review date at 50 days' do
        result[:interval] = 50
        card.next_review_date!(result)
        expect(card.review_date.beginning_of_hour).to eq(Time.now.beginning_of_hour + 50.days)
      end

      it 'should not change review date' do
        result[:quality] = 3
        card.next_review_date!(result)
        expect(card.review_date.beginning_of_hour).to eq(Time.now.beginning_of_hour)
      end
    end
  end
end
