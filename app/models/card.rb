class Card < ApplicationRecord
  belongs_to :card_type
  belongs_to :faction

  validates :name, :play_cost, :description, presence: true
  validates :play_cost, numericality: {greater_than: 0}
  validates :name, uniqueness: true
end
