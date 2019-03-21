require 'rails_helper'

feature 'User views last cards created in index' do
  scenario 'successfully' do
    
    admin1 = create(:admin, email: 'user1@email.com', password:'123456')
    card_type1 = create(:card_type, name: 'Magia')
    card_type2 = create(:card_type, name: 'Encantamento')
    faction1 = create(:faction, name: 'Ruby')
    faction2 = create(:faction, name: 'Javascript')
    create(:card, name: 'Lobisomem', card_type: card_type1, faction: faction1, play_cost: '6', 
                description: 'Uivos terríveis...', admin: admin1)
    create(:card, name: 'Guerreiro', card_type: card_type2, faction: faction2, play_cost: '4', 
                description: 'Gemidos terríveis...', admin: admin1)
    create(:card, name: 'Corneta', card_type: card_type2, faction: faction2, play_cost: '4', 
                description: 'Os lobisomens odeiam.', admin: admin1)
    create(:card, name: 'Porco', card_type: card_type2, faction: faction2, play_cost: '4', 
                description: 'Bacon.', admin: admin1)
    create(:card, name: 'Espelho', card_type: card_type2, faction: faction2, play_cost: '4', 
                description: 'Eae, lindão?', admin: admin1)
    create(:card, name: 'Escudo', card_type: card_type2, faction: faction2, play_cost: '4', 
                description: 'Capitão america.', admin: admin1)
    create(:card, name: 'Rei', card_type: card_type2, faction: faction2, play_cost: '4', 
                description: 'Michael', admin: admin1)
    create(:card, name: 'Bola de fogo', card_type: card_type2, faction: faction2, play_cost: '4', 
                description: 'Quem é?', admin: admin1)
    
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
