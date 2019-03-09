require 'rails_helper'

feature 'User views cards page' do
  scenario 'and filters only his cards' do
      
    card_type1 = CardType.create(name: 'Magia')
    card_type2 = CardType.create(name: 'Encantamento')
    faction1 = Faction.create(name: 'Ruby')
    faction2 = Faction.create(name: 'Javascript')

    user = User.create!(email: 'user@email.com', password: '123456')
    user2 = User.create!(email: 'user2@email.com', password: '789101')

    Card.create!(name: 'Lobisomem', card_type: card_type1, faction: faction1, play_cost: '3', 
                description: 'Uivos  terríveis...', highlight: false, user: user)
    Card.create!(name: 'Escudo', card_type: card_type2, faction: faction2, play_cost: '4', 
                description: 'Fiel escueiro.', highlight: false, user: user)
    Card.create!(name: 'Bola de fogo', card_type: card_type1, faction: faction1, play_cost: '6', 
                description: 'Alô, quem é?', highlight: false, user: user2)
    Card.create!(name: 'Guerreiro', card_type: card_type2, faction: faction2, play_cost: '7', 
                description: 'Meu herói....', highlight: false, user: user2)

    login_as user, :scope => :user

    visit root_path
    click_on 'Cartas'
    click_on 'Minhas cartas'

    expect(current_path).to eq my_cards_path
    expect(page).to have_css('h4', text: 'Lobisomem')
    expect(page).to have_css('h4', text: 'Escudo')
    expect(page).not_to have_css('h4', text: 'Bola de fogo')
    expect(page).not_to have_css('h4', text: 'Guerreiro')
  end

  scenario 'is not logged and cant see My cards button' do

    visit root_path
    click_on 'Cartas'

    expect(current_path).to eq cards_path
    expect(page).not_to have_link('Minhas cartas')

  end

  scenario 'then views all cards' do
    card_type1 = CardType.create(name: 'Magia')
    card_type2 = CardType.create(name: 'Encantamento')
    faction1 = Faction.create(name: 'Ruby')
    faction2 = Faction.create(name: 'Javascript')

    user = User.create!(email: 'user@email.com', password: '123456')
    user2 = User.create!(email: 'user2@email.com', password: '789101')

    Card.create!(name: 'Lobisomem', card_type: card_type1, faction: faction1, play_cost: '3', 
                description: 'Uivos  terríveis...', highlight: false, user: user)
    Card.create!(name: 'Escudo', card_type: card_type2, faction: faction2, play_cost: '4', 
                description: 'Fiel escueiro.', highlight: false, user: user)
    Card.create!(name: 'Bola de fogo', card_type: card_type1, faction: faction1, play_cost: '6', 
                description: 'Alô, quem é?', highlight: false, user: user2)
    Card.create!(name: 'Guerreiro', card_type: card_type2, faction: faction2, play_cost: '7', 
                description: 'Meu herói....', highlight: false, user: user2)

    login_as user, :scope => :user

    visit my_cards_path
    click_on 'Todas as cartas'

    expect(current_path).to eq cards_path
    expect(page).to have_css('h4', text: 'Lobisomem')
    expect(page).to have_css('h4', text: 'Escudo')
    expect(page).to have_css('h4', text: 'Bola de fogo')
    expect(page).to have_css('h4', text: 'Guerreiro')


  end


end
