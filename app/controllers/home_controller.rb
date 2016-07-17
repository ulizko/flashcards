class HomeController < ApplicationController
  before_filter :find_card, only: [:check]

  def index
    @card = if deck_current.blank? || not_reviewed_cards.blank?
              all_not_reviewed_cards
            else
              not_reviewed_cards
            end.random_card
    respond_to do |format|
      format.html
      format.js
    end
  end

  def check
    result = SuperMemo.new(@card, check_translate, time).get_result
    flash[result[:messages][:status]] = result[:messages][:message]
    @card.update_review_date!(result.except!(:messages))
    redirect_to root_path
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

  def find_card
    @card = Card.find(params[:check][:id])
  end

  def check_translate
    params[:check][:check_translate]
  end

  def time
    params[:check][:time].to_i
  end
end
