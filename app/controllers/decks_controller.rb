class DecksController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :my]

  def index
    @decks = Deck.where('private = ?', false)
  end

  def my
    @decks = current_user.decks
  end

  def new
    @deck = Deck.new
  end

  def create
    @deck = Deck.new(params.require(:deck).permit(:name, :private, :user))
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