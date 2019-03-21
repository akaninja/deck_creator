require 'rails_helper'

feature 'Admin views cards page' do
  scenario 'and filters only his cards' do
      
    card_type1 = create(:card_type, name: 'Magia')
    card_type2 = create(:card_type, name: 'Encantamento')
    faction1 = create(:faction, name: 'Ruby')
    faction2 = create(:faction, name: 'Javascript')

    admin = create(:admin, email: 'admin@email.com', password: '123456')
    admin2 = create(:admin, email: 'admin2@email.com', password: '789101')

    create(:card, name: 'Lobisomem', card_type: card_type1, faction: faction1, play_cost: '3', 
                description: 'Uivos  terríveis...', highlight: false, admin: admin)
    create(:card, name: 'Escudo', card_type: card_type2, faction: faction2, play_cost: '4', 
                description: 'Fiel escueiro.', highlight: false, admin: admin)
    create(:card, name: 'Bola de fogo', card_type: card_type1, faction: faction1, play_cost: '6', 
                description: 'Alô, quem é?', highlight: false, admin: admin2)
    create(:card, name: 'Guerreiro', card_type: card_type2, faction: faction2, play_cost: '7', 
                description: 'Meu herói....', highlight: false, admin: admin2)

    login_as admin, scope: :admin

    visit root_path
    click_on 'Cartas'
    click_on 'Minhas cartas'

    expect(current_path).to eq my_cards_path
    expect(page).to have_css('h4', text: 'Lobisomem')
    expect(page).to have_css('h4', text: 'Escudo')
    expect(page).not_to have_css('h4', text: 'Bola de fogo')
    expect(page).not_to have_css('h4', text: 'Guerreiro')
  end

  scenario 'must be logged and cant see My cards button' do

    visit root_path
    click_on 'Cartas'

    expect(current_path).to eq cards_path
    expect(page).not_to have_link('Minhas cartas')

  end

  scenario 'must be admin' do
  
    user = create(:user)
    login_as user, scope: :user

    visit cards_path

    expect(page).not_to have_link('Minhas cartas')

  end

  scenario 'then views all cards' do

    card_type1 = create(:card_type, name: 'Magia')
    card_type2 = create(:card_type, name: 'Encantamento')
    faction1 = create(:faction, name: 'Ruby')
    faction2 = create(:faction, name: 'Javascript')

    admin = create(:admin, email: 'admin@email.com', password: '123456')
    admin2 = create(:admin, email: 'admin2@email.com', password: '789101')

    create(:card, name: 'Lobisomem', card_type: card_type1, faction: faction1, play_cost: '3', 
                description: 'Uivos  terríveis...', highlight: false, admin: admin)
    create(:card, name: 'Escudo', card_type: card_type2, faction: faction2, play_cost: '4', 
                description: 'Fiel escueiro.', highlight: false, admin: admin)
    create(:card, name: 'Bola de fogo', card_type: card_type1, faction: faction1, play_cost: '6', 
                description: 'Alô, quem é?', highlight: false, admin: admin2)
    create(:card, name: 'Guerreiro', card_type: card_type2, faction: faction2, play_cost: '7', 
                description: 'Meu herói....', highlight: false, admin: admin2)

    login_as admin, scope: :admin

    visit my_cards_path
    click_on 'Todas as cartas'

    expect(current_path).to eq cards_path
    expect(page).to have_css('h4', text: 'Lobisomem')
    expect(page).to have_css('h4', text: 'Escudo')
    expect(page).to have_css('h4', text: 'Bola de fogo')
    expect(page).to have_css('h4', text: 'Guerreiro')

  end


end
