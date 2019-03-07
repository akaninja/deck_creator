require 'rails_helper'

feature 'User edits card type' do
  scenario 'successfully' do
    
    CardType.create(name: 'Criatura')

    visit root_path
    click_on 'Tipos'
    click_on 'Editar'
    fill_in 'Nome', with: 'Encantamento'
    click_on 'Enviar'

    expect(current_path).to eq card_types_path
    expect(page).to have_css('li', text: 'Encantamento')
    expect(page).not_to have_css('li', text: 'Criatura')


  end

  scenario 'and must fill in Name' do
    
    CardType.create(name: 'Criatura')

    visit root_path
    click_on 'Tipos'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Não foi possível atualizar o tipo')

  end


  scenario 'deletes a type successfully' do
    CardType.create(name: 'Criatura')

    visit root_path
    click_on 'Tipos'
    click_on 'Excluir'

    expect(current_path).to eq card_types_path
    expect(page).not_to have_css('li', text: 'Criatura')  
  end

  scenario 'deletes a type and removes several cards' do
    
    card_type1 = CardType.create(name: 'Magia')
    card_type2 = CardType.create(name: 'Encantamento')
    faction1 = Faction.create(name: 'Ruby')
    faction2 = Faction.create(name: 'Javascript')
    Card.create(name: 'Lobisomem', card_type: card_type1, faction: faction1, play_cost: '6', 
                description: 'Auuuuuuuuuu...')
    Card.create(name: 'Bola de fogo', card_type: card_type2, faction: faction2, play_cost: '4', 
                description: 'Quem é?')
    Card.create(name: 'Chuva de gelo', card_type: card_type1, faction: faction1, play_cost: '6', 
                description: 'Diacho...')
    Card.create(name: 'Guerreiro', card_type: card_type2, faction: faction2, play_cost: '4', 
                description: 'Gemidos terríveis...')
    Card.create(name: 'Lago espelhado', card_type: card_type1, faction: faction1, play_cost: '6', 
                description: 'Quem é o mais delício?')
  
    card_type1.destroy
    cards = Card.all.length

    expect(cards).to eq 2
    
  end
end