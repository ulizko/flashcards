class DecksController < ApplicationController
  def index
    @decks = current_user.decks
  end
  
  def new
    @deck = current_user.decks.build
  end
  
  def create
    @deck = current_user.decks.build(deck_params)
    if @deck.save
      flash[:success] = "Deck successful create"
      redirect_to action: 'index'
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  private
  
  def deck_params
    params.require(:deck).permit(:name, :user_id)
  end
  
  def find_deck
    @deck = Deck.find(params[:id])
  end
end