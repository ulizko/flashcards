require "rails_helper"

RSpec.describe 'Login', type: :feature do
  context 'Not login' do
    before(:each) { visit root_path }

    it 'should be not login' do
      visit root_path
      expect(page).to have_content('Please login first')
    end

    it 'should dont transition other page' do
      click_link "Все карточки"
      expect(page).to have_content('Please login first')
    end
  end

  context 'Login' do
    let!(:user) { create(:user) }
    it 'should be autorization' do
      visit root_path
      fill_in :email, with: 'example3@email.com'
      fill_in :password, with: 'qwerty123'
      click_button 'Login'
      expect(page).to have_content('Login successful')
    end
  end
end