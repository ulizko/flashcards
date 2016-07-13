require "rails_helper"

RSpec.describe SuperMemo do
  describe 'grade' do
    let(:card) { create(:card) }
    let(:check_translate) { 'orange' }

    it 'should return quality 5' do
      time = 9
      result = SuperMemo.new(card, check_translate, time).get_result
      expect(result).to include(quality: 5)
    end

    it 'should return quality 3' do
      time = 9
      check_translate = 'oragne '
      result = SuperMemo.new(card, check_translate, time).send(:grade)
      expect(result).to eq 3
    end

    it 'should return quality 3' do
      time = 25
      result = SuperMemo.new(card, check_translate, time).send(:grade)
      expect(result).to eq 3
    end

    it 'should return quality 1' do
      time = 25
      check_translate = 'peach'
      result = SuperMemo.new(card, check_translate, time).send(:grade)
      expect(result).to eq 1
    end
  end

  describe 'next_interval' do
    let(:card) { create(:card) }
    let(:check_translate) { 'orange' }
    let(:time) { 9 }

    it 'should set interval eq 1' do
      result = SuperMemo.new(card, check_translate, time).send(:next_interval)
      expect(result).to eq(1)
    end

    it 'should set interval eq 6' do
      card.repeat = 1
      card.save!
      result = SuperMemo.new(card, check_translate, time).get_result
      expect(result[:interval]).to eq(6)
    end

    it 'should set interval eq 16' do
      card.repeat = 2
      card.interval = 6
      card.save!
      result = SuperMemo.new(card, check_translate, time).get_result
      expect(result[:interval]).to eq(16)
    end
  end

  describe 'next_repeat' do
    let(:card) { create(:card) }
    let(:check_translate) { 'orange' }
    let(:time) { 9 }

    it 'should return repeat eq 1' do
      result = SuperMemo.new(card, check_translate, time).get_result
      expect(result[:repeat]).to eq(1)
    end

    it 'should return repeat eq 0' do
      check_translate = 'peach'
      result = SuperMemo.new(card, check_translate, time).get_result
      expect(result[:repeat]).to eq(0)
    end
  end
end
