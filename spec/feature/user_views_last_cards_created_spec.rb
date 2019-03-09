require 'rails_helper'

feature 'User views last cards created in index' do
  scenario 'successfully' do
    
    user1 = User.create!(email: 'user1@email.com', password:'123456')
    user2 = User.create!(email: 'user2@email.com', password:'789101')
    card_type1 = CardType.create(name: 'Magia')
    card_type2 = CardType.create(name: 'Encantamento')
    faction1 = Faction.create(name: 'Ruby')
    faction2 = Faction.create(name: 'Javascript')
    Card.create!(name: 'Lobisomem', card_type: card_type1, faction: faction1, play_cost: '6', 
                description: 'Uivos terríveis...', user: user1)
    Card.create!(name: 'Guerreiro', card_type: card_type2, faction: faction2, play_cost: '4', 
                description: 'Gemidos terríveis...', user: user1)
    Card.create!(name: 'Corneta', card_type: card_type2, faction: faction2, play_cost: '4', 
                description: 'Os lobisomens odeiam.', user: user1)
    Card.create!(name: 'Porco', card_type: card_type2, faction: faction2, play_cost: '4', 
                description: 'Bacon.', user: user1)
    Card.create!(name: 'Espelho', card_type: card_type2, faction: faction2, play_cost: '4', 
                description: 'Eae, lindão?', user: user1)
    Card.create!(name: 'Escudo', card_type: card_type2, faction: faction2, play_cost: '4', 
                description: 'Capitão america.', user: user1)
    Card.create!(name: 'Rei', card_type: card_type2, faction: faction2, play_cost: '4', 
                description: 'Michael', user: user1)
    Card.create!(name: 'Bola de fogo', card_type: card_type2, faction: faction2, play_cost: '4', 
                description: 'Quem é?', user: user1)
    
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
