require 'rails_helper'

feature 'User searches for a card' do
  scenario 'successfully' do
    card_type1 = CardType.create(name: 'Magia')
    card_type2 = CardType.create(name: 'Encantamento')
    faction1 = Faction.create(name: 'Ruby')
    faction2 = Faction.create(name: 'Javascript')

    user = User.create!(email: 'user@email.com', password: '123456')

    card1 = Card.create!(name: 'Lobisomem', card_type: card_type1, faction: faction1, play_cost: '6', description: 'Uivos terríveis...', user: user)
    card2 = Card.create!(name: 'Guerreiro', card_type: card_type2, faction: faction2, play_cost: '4', description: 'Gemidos terríveis...', user: user)
    card3 = Card.create!(name: 'Corneta', card_type: card_type2, faction: faction2, play_cost: '4', description: 'Os lobisomens odeiam.', user: user)
    
    visit root_path
    fill_in 'Busca', with: 'lobi'
    click_on 'Pesquisar'

    expect(current_path).to eq search_path
    expect(page).to have_css('h3', text: 'Lobisomem')
    expect(page).to have_css('h3', text: 'Corneta')
    expect(page).not_to have_css('h3', text: 'Guerreiro')
  end

  scenario 'and finds no matches' do
    card_type1 = CardType.create(name: 'Magia')
    card_type2 = CardType.create(name: 'Encantamento')
    faction1 = Faction.create(name: 'Ruby')
    faction2 = Faction.create(name: 'Javascript')
    card1 = Card.create(name: 'Lobisomem', card_type: card_type1, faction: faction1, play_cost: '6', description: 'Uivos terríveis...')
    card2 = Card.create(name: 'Guerreiro', card_type: card_type2, faction: faction2, play_cost: '4', description: 'Gemidos terríveis...')
    card3 = Card.create(name: 'Corneta', card_type: card_type2, faction: faction2, play_cost: '4', description: 'Os lobisomens odeiam.')
    
    visit root_path
    fill_in 'Busca', with: 'torta'
    click_on 'Pesquisar'

    expect(current_path).to eq search_path
    expect(page).to have_content('Nenhum resultado encontrado')
  end

end