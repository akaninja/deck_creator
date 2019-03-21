require 'rails_helper'

feature 'Visitor filters card list' do
  scenario 'using Faction drop down menu' do
    card_type1 = create(:card_type, name: 'Magia')
    card_type2 = create(:card_type, name: 'Encantamento')
    faction1 = create(:faction, name: 'Ruby')
    faction2 = create(:faction, name: 'Javascript')

    create(:card, name: 'Lobisomem', card_type: card_type1, faction: faction1, play_cost: '3', 
                description: 'Uivos  terríveis...')
    create(:card, name: 'Escudo', card_type: card_type2, faction: faction2, play_cost: '4', 
                description: 'Fiel escudeiro.')
    create(:card, name: 'Bola de fogo', card_type: card_type1, faction: faction1, play_cost: '6', 
                description: 'Alô, quem é?')
    create(:card, name: 'Guerreiro', card_type: card_type2, faction: faction2, play_cost: '7', 
                description: 'Meu herói....')

    visit cards_path
    select 'Ruby', from: 'Facção'
    click_on 'Filtrar'

    expect(page).to have_css('h4', text: 'Lobisomem')
    expect(page).to have_css('h4', text: 'Bola de fogo')
    expect(page).not_to have_css('h4', text: 'Escudo')
    expect(page).not_to have_css('h4', text: 'Guerreiro')

  end
  
  scenario 'using Type drop down menu' do
    
    card_type1 = create(:card_type, name: 'Magia')
    card_type2 = create(:card_type, name: 'Encantamento')
    faction1 = create(:faction, name: 'Ruby')
    faction2 = create(:faction, name: 'Javascript')

    create(:card, name: 'Lobisomem', card_type: card_type1, faction: faction1, play_cost: '3', 
                description: 'Uivos  terríveis...')
    create(:card, name: 'Escudo', card_type: card_type2, faction: faction2, play_cost: '4', 
                description: 'Fiel escudeiro.')
    create(:card, name: 'Bola de fogo', card_type: card_type1, faction: faction1, play_cost: '6', 
                description: 'Alô, quem é?')
    create(:card, name: 'Guerreiro', card_type: card_type2, faction: faction2, play_cost: '7', 
                description: 'Meu herói....')

    visit cards_path
    select 'Magia', from: 'Tipo'
    click_on 'Filtrar'

    expect(page).to have_css('h4', text: 'Lobisomem')
    expect(page).to have_css('h4', text: 'Bola de fogo')
    expect(page).not_to have_css('h4', text: 'Escudo')
    expect(page).not_to have_css('h4', text: 'Guerreiro')

  end

end
