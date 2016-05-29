class DecksController < ApplicationController
  def index
  end
  
  def new
  end
  def create
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