require 'rails_helper'

feature 'User edits faction' do 
  scenario 'successfully' do
    Faction.create(name: 'Ruby')

    visit root_path
    click_on 'Facções'
    click_on 'Editar'
    fill_in 'Nome', with: 'Javascript'
    click_on 'Enviar'

    expect(current_path).to eq factions_path
    expect(page).to have_css('li', text: 'Javascript')
    expect(page).not_to have_css('li', text: 'Ruby')

  end

  scenario 'and must fill name field' do
    Faction.create(name: 'Ruby')

    visit root_path
    click_on 'Facções'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Não foi possível atualizar a facção')
  end

  scenario 'and deletes a faction' do
    
    Faction.create(name: 'Ruby')

    visit root_path
    click_on 'Facções'
    click_on 'Excluir'
    
    expect(current_path).to eq factions_path
    expect(page).not_to have_css('li', text: 'Ruby')
    
  end

  scenario 'deletes a factions and removes several cards' do
    card_type1 = CardType.create(name: 'Magia')
    card_type2 = CardType.create(name: 'Encantamento')
    faction1 = Faction.create(name: 'Ruby')
    faction2 = Faction.create(name: 'Javascript')

    user = User.create!(email: 'user@email.com', password: '123456')

    Card.create!(name: 'Lobisomem', card_type: card_type1, faction: faction1, play_cost: '6', 
                description: 'Auuuuuuuuuu...', user: user)
    Card.create!(name: 'Bola de fogo', card_type: card_type2, faction: faction2, play_cost: '4', 
                description: 'Quem é?', user: user)
    Card.create!(name: 'Chuva de gelo', card_type: card_type1, faction: faction1, play_cost: '6', 
                description: 'Diacho...', user: user)
    Card.create!(name: 'Guerreiro', card_type: card_type2, faction: faction2, play_cost: '4', 
                description: 'Gemidos terríveis...', user: user)
    Card.create!(name: 'Lago espelhado', card_type: card_type1, faction: faction1, play_cost: '6', 
                description: 'Quem é o mais delício?', user: user)

    faction1.destroy
    cards = Card.all.length

    expect(cards).to eq 2

  end
end
