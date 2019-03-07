class CardTypesController < ApplicationController

  def index
    @card_types = CardType.all
  end

  def new
    @card_type = CardType.new
  end

  def create
    @card_type = CardType.new(card_type_params)
    if @card_type.save
      redirect_to card_types_path
    else
      flash[:alert] = 'Não foi  possível salvar o tipo'
      render :new
    end  
  end

  def edit
    @card_type = CardType.find(params[:id])
  end

  def update 
    @card_type = CardType.find(params[:id])
    if @card_type.update(card_type_params)
      redirect_to card_types_path
    else
      flash[:alert] = 'Não foi possível atualizar o tipo'
      render :edit
    end
  end

  def destroy
    @card_type = CardType.find(params[:id])
    @card_type.destroy
    redirect_to card_types_path
  end

  private 
  def card_type_params
    params.require(:card_type).permit(:name)
  end

end
