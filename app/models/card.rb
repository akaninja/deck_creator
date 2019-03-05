class Card < ApplicationRecord
  belongs_to :card_type
  belongs_to :faction

  validates :name, :play_cost, :description, presence: true
end
