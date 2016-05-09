class CardsController < ApplicationController
  before_filter :find_card, only: [:show, :edit, :update, :destroy]

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

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date)
  end

  def find_card
    @card = Card.find(params[:id])
  end
end
