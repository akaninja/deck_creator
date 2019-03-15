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
    @deck = Deck.new(deck_params)
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

  def edit
    @deck = Deck.find(params[:id])
  end

  def update
    @deck = Deck.find(params[:id])
    if @deck.update(deck_params)
      redirect_to @deck
    else
      flash[:alert] = 'Não foi possível atualizar o deck'
      render :edit
    end

  end

  def destroy
    deck = Deck.find(params[:id])
    deck.destroy
    redirect_to decks_path
  end

  private
  
  def deck_params
    params.require(:deck).permit(:name, :private, :user)
  end


end