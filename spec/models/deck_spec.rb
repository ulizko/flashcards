require "rails_helper"

RSpec.describe Deck, type: :model do
  let!(:deck) { build(:deck) }

  describe 'belongs to user' do
    it 'with user should be true' do
      expect(deck.valid?).to be_truthy
    end
  end

  describe 'set_current_deck' do
    it "deck isn't current" do
      expect(deck.current).to be_falsy
    end

    it "deck is current" do
      deck.set_current_deck
      expect(deck.current).to be_truthy
    end
  end
end
