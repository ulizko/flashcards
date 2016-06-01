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
    before(:all) { @card = create(:card) }

    describe '#check_card' do
      it { expect(@card.check_card('car')).to be_truthy }
    end

    describe '#increase_review_date!' do
      before(:each) { @card.increase_review_date! }

      it 'should increase review date by 12 hours' do
        expect(@card.review_date.beginning_of_hour).to eq(Time.now.beginning_of_hour + 12.hour)
      end

      it 'should increase review date by 3 days' do
        expect(@card.review_date.beginning_of_hour).to eq(Time.now.beginning_of_hour + 3.day)
      end

      it 'should increase review date by 1 week' do
        expect(@card.review_date.beginning_of_hour).to eq(Time.now.beginning_of_hour + 1.week)
      end

      it 'should increase review date by 2 weeks' do
        expect(@card.review_date.beginning_of_hour).to eq(Time.now.beginning_of_hour + 2.week)
      end

      it 'should increase review date by 1 month' do
        expect(@card.review_date.beginning_of_hour).to eq(Time.now.beginning_of_hour + 1.month)
      end
    end

    describe '#decrease_review_date!' do
      it 'should decrease review date' do
        3.times { @card.decrease_review_date! }
        expect(@card.review_date.beginning_of_hour).to eq(Time.now.beginning_of_hour + 12.hour)
      end
    end
  end
end
