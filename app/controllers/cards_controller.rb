class CardsController < ApplicationController
  before_action :authenticate_admin!, only:[:new, :create, :edit, :update, :destroy, :highlight, :unhighlight, :my]

  def index
    @factions = Faction.all
    @card_types = CardType.all
    if params[:faction_id]
      @cards = Card.where(faction: params[:faction_id])
    elsif params[:card_type_id]
      @cards = Card.where(card_type: params[:card_type_id])
    elsif params[:faction_id] && params[:card_type_id]
      @cards = Card.where("faction = ? AND card_type = ?", params[:faction_id], params[:card_type_id])
    else 
      @cards = Card.all
    end
  end

  def my
    @cards = current_admin.cards
  end

  def new
    @card = Card.new
    @factions = Faction.all
    @card_types = CardType.all
  end

  def create
    @card = Card.new(card_params)
    @card.admin = current_admin
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
    return @user_decks = current_user.decks if user_signed_in?
    # if user_signed_in?
    #   @user_decks = current_user.decks
    # end

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

  def highlight
    @card = Card.find(params[:id])
    @card.update(highlight: true)
    redirect_to @card
  end

  def unhighlight
    @card = Card.find(params[:id])
    @card.update(highlight: false)
    redirect_to @card
  end

  def add_to_deck
    @card = Card.find(params[:id])
    @deck = Deck.find(params[:deck_id])

    @deck_card = DeckCard.create!(deck: @deck, card: @card)
    if @deck_card.save
      flash[:notice] = "Carta adicionada ao Deck: #{@deck.name}"
      redirect_to cards_path
    else
      flash[:alert] = 'Não foi possível adicionar a carta ao deck'
    end
  end

  def send_email
    @card = Card.find(params[:id])
    @email_adress = params[:email_adress]
    if CardsMailer.email_card(@card.id, @email_adress)  
      flash[:notice] = 'E-mail enviado'
      redirect_to @card
    end
  end

  private 

  def card_params
    params.require(:card).permit(:name, :play_cost, :description, :card_type_id, :faction_id, :art, highlight: false)
  end
  
end