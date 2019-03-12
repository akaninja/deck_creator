class CardsMailer < ApplicationMailer

  def email_card(card_id, email_adress)
    @card = Card.find(card_id)
    mail(to: email_adress)
   
  end

end