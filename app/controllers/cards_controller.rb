class CardsController < ApplicationController
  before_filter :find_card, except: [:new, :create, :index]

  def new
    @card = current_user.cards.new
  end

  def create
    @card = current_user.cards.new(card_params)
    if @card.save
      flash[:success] = t('successful_create_card')
      redirect_to action: 'index'
    else
      render 'new'
    end
  end

  def index
    @cards = current_user.cards
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

  def check
    if @card.check_card?(check_translate)
      flash[:success] = t('right')
      @card.increase_review_date!
    elsif @card.short_distance?(check_translate)
      flash[:success] = t('oops', original_text: @card.original_text, check_translate: check_translate)
      @card.increase_review_date!
    else
      flash[:danger] = t('wrong')
      @card.decrease_review_date!
    end
    redirect_to root_path
  end

  private

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date,
                                 :deck_id, :user_id, :image)
  end

  def find_card
    @card = Card.find(params[:id])
  end

  def check_translate
    params[:check][:check_translate]
  end
end
