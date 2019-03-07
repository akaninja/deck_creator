require 'rails_helper'

feature 'User views last cards created in index' do
  scenario 'successfully' do
    
    card_type1 = CardType.create(name: 'Magia')
    card_type2 = CardType.create(name: 'Encantamento')
    faction1 = Faction.create(name: 'Ruby')
    faction2 = Faction.create(name: 'Javascript')
    Card.create(name: 'Lobisomem', card_type: card_type1, faction: faction1, play_cost: '6', description: 'Uivos terríveis...')
    Card.create(name: 'Guerreiro', card_type: card_type2, faction: faction2, play_cost: '4', description: 'Gemidos terríveis...')
    Card.create(name: 'Corneta', card_type: card_type2, faction: faction2, play_cost: '4', description: 'Os lobisomens odeiam.')
    Card.create(name: 'Porco', card_type: card_type2, faction: faction2, play_cost: '4', description: 'Bacon.')
    Card.create(name: 'Espelho', card_type: card_type2, faction: faction2, play_cost: '4', description: 'Eae, lindão?')
    Card.create(name: 'Escudo', card_type: card_type2, faction: faction2, play_cost: '4', description: 'Capitão america.')
    Card.create(name: 'Rei', card_type: card_type2, faction: faction2, play_cost: '4', description: 'Michael')
    Card.create(name: 'Bola de fogo', card_type: card_type2, faction: faction2, play_cost: '4', description: 'Quem é?')
    
    visit root_path

    expect(page).to have_css('h3', text: 'Bola de fogo')
    expect(page).to have_css('h3', text: 'Rei')
    expect(page).to have_css('h3', text: 'Escudo')
    expect(page).to have_css('h3', text: 'Espelho')
    expect(page).to have_css('h3', text: 'Porco')

    expect(page).not_to have_css('h3', text: 'Corneta')
    expect(page).not_to have_css('h3', text: 'Guerreiro')
    expect(page).not_to have_css('h3', text: 'Lobisomem')

  end
end
