class HomeController < ApplicationController
  def index
    @card = current_user.cards.review.random_card
  end
end
