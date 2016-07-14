require "rails_helper"

RSpec.describe SuperMemo do
  describe 'grade' do
    let(:card) { create(:card) }

    it 'should return quality 5' do
      result = SuperMemo.new(card, 'orange', 9).get_result
      expect(result).to include(quality: 5)
    end

    it 'should return quality 3' do
      result = SuperMemo.new(card, 'oragne', 9).grade
      expect(result).to eq 3
    end

    it 'should return quality 3' do
      result = SuperMemo.new(card, 'orange', 25).grade
      expect(result).to eq 3
    end

    it 'should return quality 1' do
      result = SuperMemo.new(card, 'peach', 25).grade
      expect(result).to eq 1
    end
  end

  describe 'next_interval' do
    let(:card) { create(:card) }

    it 'should set interval eq 1' do
      result = SuperMemo.new(card, 'orange', 9).next_interval
      expect(result).to eq(1)
    end

    it 'should set interval eq 6' do
      card.repeat = 1
      card.save!
      result = SuperMemo.new(card, 'orange', 9).get_result
      expect(result[:interval]).to eq(6)
    end

    it 'should set interval eq 16' do
      card.repeat = 2
      card.interval = 6
      card.save!
      result = SuperMemo.new(card, 'orange', 9).get_result
      expect(result[:interval]).to eq(16)
    end
  end

  describe 'next_repeat' do
    let(:card) { create(:card) }

    it 'should return repeat eq 1' do
      result = SuperMemo.new(card, 'orange', 9).get_result
      expect(result[:repeat]).to eq(1)
    end

    it 'should return repeat eq 0' do
      result = SuperMemo.new(card, 'peach', 9).get_result
      expect(result[:repeat]).to eq(0)
    end
  end
end
