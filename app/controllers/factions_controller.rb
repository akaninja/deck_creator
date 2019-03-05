class FactionsController < ApplicationController

  def index
    @factions = Faction.all
  end

  def new
    @faction = Faction.new
  end

  def create
    @faction = Faction.new(params.require(:faction).permit(:name))
    if @faction.save
      redirect_to factions_path
    else
      flash[:alert] = 'Não foi possível salvar a facção'
      render :new
    end
  end

  private 


end
