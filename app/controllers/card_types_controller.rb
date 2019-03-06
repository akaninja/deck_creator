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


  private 
  def card_type_params
    params.require(:card_type).permit(:name)
  end

end
