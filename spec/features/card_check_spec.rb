require "rails_helper"

RSpec.describe "Card check", type: :feature do
  let!(:user) { create(:user) }
  let!(:card) { create(:card, user: user) }
  before(:each) do
    visit root_path
    click_link I18n.t('layouts.application.login')
    fill_in :email, with: user[:email]
    fill_in :password, with: 'qwerty123'
    click_button I18n.t('layouts.application.login')
  end
  it 'should be Right' do
    expect(page).to have_content('машина')
    fill_in :check_check_translate, with: 'Car'
    click_button I18n.t('home.form.check_card')
    expect(page).to have_content(I18n.t('cards.check.right'))
  end

  it 'should be Oops' do
    fill_in :check_check_translate, with: 'acr'
    click_button I18n.t('home.form.check_card')
    expect(page).to have_content(I18n.t('cards.check.oops',
                                        original_text: card.original_text,
                                        check_translate: 'acr'))
  end

  it 'should be Wrong' do
    fill_in :check_check_translate, with: 'bike'
    click_button I18n.t('home.form.check_card')
    expect(page).to have_content(I18n.t('cards.check.wrong'))
  end
end
