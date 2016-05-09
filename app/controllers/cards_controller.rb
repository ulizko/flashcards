class CardsController < ApplicationController

  before_filter :find_card, only: [:show, :edit, :update, :destroy]
  after_filter  :set_review_date, only: :show

  def new
    @card = Card.new
  end

  def create
    @card = Card.new(card_params)
    if @card.save
      redirect_to action: 'index'
    else
      render 'new'
    end
  end

  def index
    @cards = Card.all
  end

  def show
  end

  def edit
  end

  def update
    if @card.update(card_params)
      redirect_to action: 'index'
    else
      render 'edit'
    end
  end

  def destroy
    @card.destroy
    redirect_to cards_path
  end

  private

  def set_review_date
    @card.update_attribute(:review_date, Time.now + 3 * 60 * 60 * 24)
  end

  def card_params
    params.require(:card).permit(:original_text, :translated_text)
  end

  def find_card
    @card = Card.find(params[:id])
  end
end
