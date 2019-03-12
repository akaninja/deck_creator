require 'rails_helper'

RSpec.describe CardsMailer do
  describe '.email_card' do
    it 'should send email to given email adress' do
      card_type1 = CardType.create(name: 'Magia')
      faction1 = Faction.create(name: 'Ruby')
      user = User.create!(email: 'user@email.com', password: '123456')
      card1 = Card.create!(name: 'Lobisomem', card_type: card_type1, faction: faction1, play_cost: '6',                     description: 'Uivos terríveis...', user: user)

      email_adress = 'friend@email.com'

      mail = CardsMailer.email_card(card1.id, email_adress)

      expect(mail.to).to eq([email_adress])

    end

    it 'should have card name' do
      card_type1 = CardType.create(name: 'Magia')
      faction1 = Faction.create(name: 'Ruby')
      user = User.create!(email: 'user@email.com', password: '123456')
      card1 = Card.create!(name: 'Lobisomem', card_type: card_type1, faction: faction1, play_cost: '6',                     description: 'Uivos terríveis...', user: user)

      email_adress = 'friend@email.com'

      mail = CardsMailer.email_card(card1.id, email_adress)

      expect(mail.body).to include(card1.name)

    end

  end
end
