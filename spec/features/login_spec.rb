require "rails_helper"

RSpec.describe 'Login', type: :feature do
  context 'Not login' do
    before(:each) { visit root_path }

    it 'should be not login' do
      expect(page).to have_content('Please login first')
    end

    it "can't show cards" do
      expect(page).not_to have_content('Все карточки')
    end

    it "can't add cards" do
      expect(page).not_to have_content('Добавить карточку')
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
