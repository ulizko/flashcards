require "rails_helper"

RSpec.describe "Card check", type: :feature do
  let!(:user) { create(:user) }
  let!(:card) { create(:card, user: user) }
  before(:each) do
    visit root_path
    click_link "Login"
    fill_in :email, with: user[:email]
    fill_in :password, with: 'qwerty123'
    click_button "Login"
  end
  it 'should be Right' do
    expect(page).to have_content('машина')
    fill_in :check_check_translate, with: 'Car'
    click_button 'Check card'
    expect(page).to have_content('Right. Let\'s check next card.')
  end
  it 'should be Wrong' do
    fill_in :check_check_translate, with: 'bike'
    click_button 'Check card'
    expect(page).to have_content('Wrong! Try another card.')
  end
end
