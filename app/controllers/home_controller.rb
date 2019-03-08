class HomeController < ApplicationController

  def index
    @highlight_cards = Card.where('highlight like ?', true)
    @cards = Card.last(5)
  end

end