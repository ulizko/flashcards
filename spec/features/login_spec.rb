require "rails_helper"

RSpec.describe 'Login', type: :feature do
  context 'when not login' do
    before(:each) { visit login_path }

    it 'should be not login' do
      visit cards_path
      expect(page).to have_content('Please login first')
    end

    it "can't show cards" do
      expect(page).not_to have_content('My decks')
    end

    it "can't add cards" do
      expect(page).not_to have_content('Добавить карточку')
    end
  end

  context 'when login' do
    let!(:user) { create(:user, email: 'example@email.com') }
    it 'should be autorization' do
      visit login_path
      fill_in :email, with: 'example@email.com'
      fill_in :password, with: 'qwerty123'
      click_button 'Login'
      expect(page).to have_content('Login successful')
    end
  end
end
