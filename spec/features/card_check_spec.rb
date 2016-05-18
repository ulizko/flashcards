require "rails_helper"

RSpec.describe "Card check", type: :feature do
  let!(:card) { create(:card, review_date: 3.days.ago) }
  before(:each) { visit root_path }
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