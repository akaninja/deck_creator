require 'rails_helper'

feature 'User sends email with card link' do
  scenario 'successfully' do
    card_type1 = CardType.create(name: 'Magia')
    faction1 = Faction.create(name: 'Ruby')
    user = User.create!(email: 'user@email.com', password: '123456')
    card1 = Card.create!(name: 'Lobisomem', card_type: card_type1, faction: faction1, play_cost: '6',                     description: 'Uivos terríveis', user: user)
    mailer_spy = class_spy(CardsMailer)
    stub_const('CardsMailer', mailer_spy) 

    login_as user, :scope => :user

    visit root_path
    click_on 'Lobisomem'
    fill_in 'Email', with: 'friend@email.com'
    click_on 'Enviar'

    card = Card.last
    expect(CardsMailer).to have_received(:email_card).with(card.id,'friend@email.com')
    expect(page).to have_content('E-mail enviado')

  end

end

