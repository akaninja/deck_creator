class DeckCardsController < ApplicationController

  def destroy
    @deck_card = DeckCard.find(params[:id])
    @deck_card.destroy
    redirect_to deck_path(@deck_card.deck.id)
  end

end