class HomeController < ApplicationController

  def index
    @cards = Card.last(5)
  end

end