require 'rails_helper'

feature 'Visitor searches for a card' do
  scenario 'successfully' do
    card_type1 = create(:card_type, name: 'Magia')
    card_type2 = create(:card_type, name: 'Encantamento')
    faction1 = create(:faction, name: 'Ruby')
    faction2 = create(:faction, name: 'Javascript')

    card1 = create(:card, name: 'Lobisomem', card_type: card_type1, faction: faction1, play_cost: '6', description: 'Uivos terríveis...')
    card2 = create(:card, name: 'Guerreiro', card_type: card_type2, faction: faction2, play_cost: '4', description: 'Gemidos terríveis...')
    card3 = create(:card, name: 'Corneta', card_type: card_type2, faction: faction2, play_cost: '4', description: 'Os lobisomens odeiam.')
    
    visit root_path
    fill_in 'Busca', with: 'lobi'
    click_on 'Pesquisar'

    expect(current_path).to eq search_path
    expect(page).to have_css('h3', text: 'Lobisomem')
    expect(page).to have_css('h3', text: 'Corneta')
    expect(page).not_to have_css('h3', text: 'Guerreiro')
  end

  scenario 'and finds no matches' do
    card_type1 = create(:card_type, name: 'Magia')
    card_type2 = create(:card_type, name: 'Encantamento')
    faction1 = create(:faction, name: 'Ruby')
    faction2 = create(:faction, name: 'Javascript')
    card1 = create(:card, name: 'Lobisomem', card_type: card_type1, faction: faction1, play_cost: '6', description: 'Uivos terríveis...')
    card2 = create(:card, name: 'Guerreiro', card_type: card_type2, faction: faction2, play_cost: '4', description: 'Gemidos terríveis...')
    card3 = create(:card, name: 'Corneta', card_type: card_type2, faction: faction2, play_cost: '4', description: 'Os lobisomens odeiam.')
    
    visit root_path
    fill_in 'Busca', with: 'torta'
    click_on 'Pesquisar'

    expect(current_path).to eq search_path
    expect(page).to have_content('Nenhum resultado encontrado')
  end

end