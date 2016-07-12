require "rails_helper"

RSpec.describe SuperMemo do
  describe 'grade' do
    let(:card) { create(:card) }

    it 'should return quality 5' do
      result = SuperMemo.new(card, true, 9, 0).get_result
      expect(result).to include(quality: 5)
    end

    it 'should return quality 3' do
      result = SuperMemo.new(card, true, 9, 2).send(:grade)
      expect(result).to eq 3
    end

    it 'should return quality 3' do
      result = SuperMemo.new(card, true, 25, 0).send(:grade)
      expect(result).to eq 3
    end

    it 'should return quality 1' do
      result = SuperMemo.new(card, false, 25, 4).send(:grade)
      expect(result).to eq 1
    end
  end

  describe 'next_interval' do
    let(:card) { create(:card) }

    it 'should set interval eq 1' do
      result = SuperMemo.new(card, true, 9, 0).send(:next_interval)
      expect(result).to eq(1)
    end

    it 'should set interval eq 6' do
      card.repeat = 1
      card.save!
      result = SuperMemo.new(card, true, 9, 0).get_result
      expect(result[:interval]).to eq(6)
    end

    it 'should set interval eq 16' do
      card.repeat = 2
      card.interval = 6
      card.save!
      result = SuperMemo.new(card, true, 9, 0).get_result
      expect(result[:interval]).to eq(16)
    end
  end

  describe 'next_repeat' do
    let(:card) { create(:card) }

    it 'should return repeat eq 1' do
      result = SuperMemo.new(card, true, 9, 0).get_result
      expect(result[:repeat]).to eq(1)
    end

    it 'should return repeat eq 0' do
      result = SuperMemo.new(card, false, 9, 0).get_result
      expect(result[:repeat]).to eq(0)
    end
  end
end
