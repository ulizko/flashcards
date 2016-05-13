class HomeController < ApplicationController
  def index
    @card = Card.review.random_card
  end
end
