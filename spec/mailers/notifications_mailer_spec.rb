require "rails_helper"

RSpec.describe NotificationsMailer, type: :mailer do
  let(:user) { create :user, email: 'test@test.com' }
  let(:email) { NotificationsMailer.pending_cards(user).deliver_now }

  it 'sends notifications' do
    expect(email.to).to include('test@test.com')
  end
end
