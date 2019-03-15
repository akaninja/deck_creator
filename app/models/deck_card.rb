class DeckCard < ApplicationRecord
  belongs_to :deck, optional: true
  belongs_to :card, optional: true
end
