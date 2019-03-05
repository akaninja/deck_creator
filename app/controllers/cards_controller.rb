class CardsController < ApplicationController

  def new
    @card = Card.new
    @factions = Faction.all
    @card_types = CardType.all
  end

  def create
    @card = Card.new(card_params)
    if @card.save
      redirect_to @card
    else
      @factions = Faction.all
      @card_types = CardType.all
      flash[:alert] = 'Não foi possível salvar a carta'
      render :new
    end
  end

  def show
    @card = Card.find(params[:id])
  end

  private 

  def card_params
    params.require(:card).permit(:name, :play_cost, :description, :card_type_id, :faction_id)
  end
  
end