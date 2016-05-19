require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:card1) { create(:card, user: user) }
  let(:card2) { create(:card, user: user) }

  it 'user should be have many cards' do
    expect(user.cards).to match_array([card1, card2])
  end
end
