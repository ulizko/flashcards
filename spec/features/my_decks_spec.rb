require "rails_helper"

RSpec.describe 'My decks', type: :feature do
  let!(:user) { create(:user, email: 'example@email.com') }
  let!(:deck) { create(:deck, user: user) }
  let!(:card) { create(:card, deck: deck) }

  before(:each) do
    visit root_path
    fill_in :email, with: 'example@email.com'
    fill_in :password, with: 'qwerty123'
    click_button 'Login'
    visit('/decks')
  end

  context 'Decks' do
    it 'have link My decks' do
      expect(page).to have_content('My decks')
    end

    it 'show all user decks' do
      expect(page).to have_content('Transport')
    end
  end

  context 'Current deck' do
    it 'have button Set current' do
      expect(page).to have_selector("input[type=submit][value='Set current']")
    end

    it 'have button Uset current' do
      click_button 'Set current'
      expect(page).to have_selector("input[type=submit][value='Unset current']")
    end
  end
end
