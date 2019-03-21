class Card < ApplicationRecord
  belongs_to :card_type 
  belongs_to :faction
  belongs_to :admin

  has_many :deck_cards
  
  validates :name, :play_cost, :description, presence: true
  validates :play_cost, numericality: {greater_than: 0}
  validates :name, uniqueness: true

  has_one_attached :art
  
end
