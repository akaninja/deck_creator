require 'rails_helper'

RSpec.describe CardsMailer do
  describe '.email_card' do
    it 'should send email to given email adress' do

      card1 = create(:card)
      email_adress = 'friend@email.com'

      mail = CardsMailer.email_card(card1.id, email_adress)

      expect(mail.to).to eq([email_adress])

    end

    it 'should have card name' do
      
      card1 = create(:card, name: 'Sou eu, bola de fogo!')
      email_adress = 'friend@email.com'

      mail = CardsMailer.email_card(card1.id, email_adress)

      expect(mail.body).to include(card1.name)
      #expect(mail.body).to have_link(card1.name)

    end

  end
end
