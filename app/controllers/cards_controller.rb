class CardsController < ApplicationController
  before_filter :find_card, except: [:new, :create, :index]

  def new
    @card = current_user.cards.new
  end

  def create
    @card = current_user.cards.new(card_params)
    if @card.save
      flash[:success] = "Card successful create"
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
      flash[:success] = "Right. Let's check next card."
      @card.increase_review_date!
    elsif @card.short_distance?(check_translate)
      flash[:success] = <<-MSG
                    Oops! Your answer is correct, but you made a typo.
                    Right translate: <strong>#{@card.original_text}</strong>,
                    you typed: <strong>#{check_translate}</strong>
      MSG
      @card.increase_review_date!
    else
      flash[:danger] = "Wrong! Try another card."
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
