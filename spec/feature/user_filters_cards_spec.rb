require 'rails_helper'

feature 'User filters card list' do
  scenario 'using Faction drop down menu' do
    card_type1 = CardType.create(name: 'Magia')
    card_type2 = CardType.create(name: 'Encantamento')
    faction1 = Faction.create(name: 'Ruby')
    faction2 = Faction.create(name: 'Javascript')

    user = User.create!(email: 'user@email.com', password: '123456')
    user2 = User.create!(email: 'user2@email.com', password: '789101')

    Card.create!(name: 'Lobisomem', card_type: card_type1, faction: faction1, play_cost: '3', 
                description: 'Uivos  terríveis...', highlight: false, user: user)
    Card.create!(name: 'Escudo', card_type: card_type2, faction: faction2, play_cost: '4', 
                description: 'Fiel escudeiro.', highlight: false, user: user)
    Card.create!(name: 'Bola de fogo', card_type: card_type1, faction: faction1, play_cost: '6', 
                description: 'Alô, quem é?', highlight: false, user: user2)
    Card.create!(name: 'Guerreiro', card_type: card_type2, faction: faction2, play_cost: '7', 
                description: 'Meu herói....', highlight: false, user: user2)

    login_as user, :scope => :user

    visit cards_path
    select 'Ruby', from: 'Facção'
    click_on 'Filtrar'

    expect(page).to have_css('h4', text: 'Lobisomem')
    expect(page).to have_css('h4', text: 'Bola de fogo')
    expect(page).not_to have_css('h4', text: 'Escudo')
    expect(page).not_to have_css('h4', text: 'Guerreiro')

  end
  
  scenario 'using Type drop down menu' do
    
    card_type1 = CardType.create(name: 'Magia')
    card_type2 = CardType.create(name: 'Encantamento')
    faction1 = Faction.create(name: 'Ruby')
    faction2 = Faction.create(name: 'Javascript')

    user = User.create!(email: 'user@email.com', password: '123456')
    user2 = User.create!(email: 'user2@email.com', password: '789101')

    Card.create!(name: 'Lobisomem', card_type: card_type1, faction: faction1, play_cost: '3', 
                description: 'Uivos  terríveis...', highlight: false, user: user)
    Card.create!(name: 'Escudo', card_type: card_type2, faction: faction2, play_cost: '4', 
                description: 'Fiel escudeiro.', highlight: false, user: user)
    Card.create!(name: 'Bola de fogo', card_type: card_type1, faction: faction1, play_cost: '6', 
                description: 'Alô, quem é?', highlight: false, user: user2)
    Card.create!(name: 'Guerreiro', card_type: card_type2, faction: faction2, play_cost: '7', 
                description: 'Meu herói....', highlight: false, user: user2)

    login_as user, :scope => :user

    visit cards_path
    select 'Magia', from: 'Tipo'
    click_on 'Filtrar'

    expect(page).to have_css('h4', text: 'Lobisomem')
    expect(page).to have_css('h4', text: 'Bola de fogo')
    expect(page).not_to have_css('h4', text: 'Escudo')
    expect(page).not_to have_css('h4', text: 'Guerreiro')

  end

end
