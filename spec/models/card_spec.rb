require "rails_helper"

RSpec.describe Card, :type => :model do
  let(:card) { FactoryGirl.create(:card) }
  describe 'validations' do
    subject { card }
    it { expect(subject.valid?).to be_truthy }
    it { should_not allow_value("word5").for(:original_text) }
    it { should_not allow_value(" word").for(:original_text) }
    it { should_not allow_value("слово").for(:original_text) }
    it { should allow_value("word").for(:original_text) }
    it { should_not allow_value("слово5").for(:translated_text) }
    it { should allow_value("Ёпр (-ст);").for(:translated_text) }
    it { should_not allow_value("word").for(:translated_text) }
    it { should validate_presence_of(:original_text) }
    it { should validate_presence_of(:translated_text) }
  end

  describe '#set_review_date' do
    let(:card) { FactoryGirl.build(:card) }
    it { expect(card.review_date).to be_nil }
    subject { FactoryGirl.create(:card) }
    it { expect(subject.review_date).to eq(Date.today + 3) }
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