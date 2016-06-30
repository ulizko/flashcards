require "rails_helper"

RSpec.describe "Send email", type: :feature do
  let(:user) { create :user, email: 'test@test.com' }
  before(:each) { NotificationsMailer.pending_cards(user).deliver_now }

  it 'sends an email' do
    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end

  it 'send to' do
    expect(ActionMailer::Base.deliveries.last.to).to include(user.email)
  end
end
