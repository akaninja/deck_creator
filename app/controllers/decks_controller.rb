class DecksController < ApplicationController
  before_action :authenticate_user! 

  def index
    @decks = Deck.all
  end

  def new
    @deck = Deck.new
  end

  def create
    @deck = Deck.new(params.require(:deck).permit(:name, :user))
    @deck.user = current_user
    if @deck.save
      redirect_to decks_path
    else
      flash[:alert] = 'Não foi possível criar o deck'
      render :new
    end
  end

  def show
    @deck = Deck.find(params[:id])
  end

end