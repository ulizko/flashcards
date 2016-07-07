class DecksController < ApplicationController
  before_filter :find_deck, except: [:new, :create, :index]

  def index
    @decks = current_user.decks.order(:id)
  end

  def new
    @deck = current_user.decks.build
  end

  def create
    @deck = current_user.decks.build(deck_params)
    if @deck.save
      flash[:success] = t('.successful_create_deck')
      redirect_to action: :index
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @deck.update(deck_params)
      flash[:success] = t('.successful_set_current')
      redirect_to action: :index
    else
      render 'edit'
    end
  end

  def show
    @cards = @deck.cards
  end

  def destroy
  end

  private

  def deck_params
    params.require(:deck).permit(:name, :user_id, :current)
  end

  def find_deck
    @deck = Deck.find(params[:id])
  end
end
