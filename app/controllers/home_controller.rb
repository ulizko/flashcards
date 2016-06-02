class HomeController < ApplicationController
  def index
    @card = if deck_blank? || cards_blank?
              current_user.cards.review.random_card
            else
              current_user.decks.current.take.cards.review.random_card
            end
  end

  private

  def deck_blank?
    current_user.decks.current.blank?
  end

  def cards_blank?
    current_user.decks.current.take.cards.review.blank?
  end
end
