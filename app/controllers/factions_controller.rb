class FactionsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @factions = Faction.all
  end

  def new
    @faction = Faction.new
  end

  def create
    @faction = Faction.new(faction_params)
    if @faction.save
      redirect_to factions_path
    else
      flash[:alert] = 'Não foi possível salvar a facção'
      render :new
    end
  end

  def edit
    @faction = Faction.find(params[:id])
  end

  def update
    @faction = Faction.find(params[:id])
    if @faction.update(faction_params)
      redirect_to factions_path
    else
      flash[:alert] = 'Não foi possível atualizar a facção'
      render :edit
    end
  end

  def destroy
    @faction = Faction.find(params[:id])
    @faction.destroy
    redirect_to factions_path
  end
  
  private 
  def faction_params
    params.require(:faction).permit(:name)
  end

end
