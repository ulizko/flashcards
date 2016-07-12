class CardsController < ApplicationController
  before_filter :find_card, except: [:new, :create, :index]

  def new
    @card = current_user.cards.new
  end

  def create
    @card = current_user.cards.new(card_params)
    if @card.save
      flash[:success] = t('.successful_create_card')
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
    typo = @card.levenstein(check_translate)
    cheked = @card.check_card?(check_translate)
    if cheked && time > 30
      flash[:success] = t('.too_long')
    elsif cheked
      flash[:success] = t('.right')
    elsif typo <= 2
      flash[:success] = t('.oops', original_text: @card.original_text,
                                  check_translate: check_translate)
    else
      flash[:danger] = t('.wrong')
    end
    result = SuperMemo.new(@card, cheked, time, typo).get_result
    @card.next_review_date!(result)
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

  def time
    params[:check][:time].to_i
  end
end
