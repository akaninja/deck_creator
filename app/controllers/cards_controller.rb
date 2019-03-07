class CardsController < ApplicationController

  def index
    @cards = Card.all
  end

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
      render 'new'
    end
  end

  def show
    @card = Card.find(params[:id])
  end

  def edit
    @card = Card.find(params[:id])
    @factions = Faction.all
    @card_types = CardType.all
  end

  def update
    @card = Card.find(params[:id])
    if @card.update(card_params)
      redirect_to @card
    else
      @factions = Faction.all
      @card_types = CardType.all
      flash[:alert] = 'Não foi possível atualizar a carta'
      render :edit
    end
  end

  def destroy
    @card = Card.find(params[:id])
    @card.destroy
    redirect_to cards_path
  end

  def search
    @search_results = Card.where('name like ? OR description like ?', "%#{params[:q]}%", "%#{params[:q]}%" )
    if @search_results.empty?
      flash[:alert] = 'Nenhum resultado encontrado'
    end
  end

  private 

  def card_params
    params.require(:card).permit(:name, :play_cost, :description, :card_type_id, :faction_id, :art)
  end
  
end