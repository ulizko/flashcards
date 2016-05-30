class HomeController < ApplicationController
  def index
    @card = if current_user.decks.current.blank?
              current_user.cards.review.random_card
            else
              current_user.decks.current.take.cards.review.random_card
            end
  end
end
