class CardType < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true
  has_many :cards, dependent: :delete_all

end
