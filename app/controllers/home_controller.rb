class HomeController < ApplicationController
  def index
    if current_user.decks.current.blank?
      @card = current_user.cards.review.random_card
    else
      @card = current_user.decks.current.take.cards.review.random_card
    end
  end
end
