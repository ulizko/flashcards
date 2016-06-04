class HomeController < ApplicationController
  def index
    @card = if deck_current.blank? || not_reviewed_cards.blank?
              all_not_reviewed_cards
            else
              not_reviewed_cards
            end.random_card
  end

  private

  def deck_current
    current_user.decks.current
  end

  def not_reviewed_cards
    current_user.decks_not_reviewed
  end

  def all_not_reviewed_cards
    current_user.cards.review
  end
end
