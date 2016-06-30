require 'rails_helper'

RSpec.describe User, type: :model do
  subject { create :user }

  it 'sends an email' do
    expect { User.notify_not_viewed_cards }
      .to change { ActionMailer::Base.deliveries.count }.by(1)
  end
end
