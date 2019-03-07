require 'rails_helper'

feature 'User edits card info' do
  scenario 'successfully' do
    card_type1 = CardType.create(name: 'Magia')
    card_type2 = CardType.create(name: 'Encantamento')
    faction1 = Faction.create(name: 'Ruby')
    faction2 = Faction.create(name: 'Javascript')
    card1 = Card.create(name: 'Lobisomem', card_type: card_type1, faction: faction1, play_cost: '6', description: 'Uivos terríveis...')
    card2 = Card.create(name: 'Guerreiro', card_type: card_type2, faction: faction2, play_cost: '4', description: 'Gemidos terríveis...')

    visit root_path
    click_on 'Todas as cartas'
    click_on 'Lobisomem'
    click_on 'Editar'

    select 'Javascript', from: 'Facção'
    fill_in 'Nome', with: 'Selo contra Lobisomem'
    fill_in 'Custo', with: '5'
    select 'Encantamento', from: 'Tipo'
    fill_in 'Descrição', with: 'Vira, vira, vira homem... vira, vira lobisomem'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Selo contra Lobisomem')
    expect(page).to have_css('h3', text: 'Javascript')
    expect(page).to have_css('p', text: '5 mana')
    expect(page).to have_css('p', text: 'Encantamento')
    expect(page).to have_css('p', text: 'Vira, vira, vira homem... vira, vira lobisomem')

  end

  scenario 'and must fill all fields' do
    card_type1 = CardType.create(name: 'Magia')
    faction1 = Faction.create(name: 'Ruby')
    card1 = Card.create(name: 'Lobisomem', card_type: card_type1, faction: faction1, play_cost: '6', description: 'Uivos terríveis...')
    
    visit root_path
    click_on 'Todas as cartas'
    click_on 'Lobisomem'
    click_on 'Editar'

    fill_in 'Nome', with: ''
    fill_in 'Custo', with: ''
    fill_in 'Descrição', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Não foi possível atualizar a carta')

  end

  scenario 'and deletes card successfully' do
    card_type1 = CardType.create(name: 'Magia')
    card_type2 = CardType.create(name: 'Encantamento')
    faction1 = Faction.create(name: 'Ruby')
    faction2 = Faction.create(name: 'Javascript')
    card1 = Card.create(name: 'Lobisomem', card_type: card_type1, faction: faction1, play_cost: '6', description: 'Uivos terríveis...')
    card2 = Card.create(name: 'Guerreiro', card_type: card_type2, faction: faction2, play_cost: '4', description: 'Gemidos terríveis...')
    
    visit root_path
    click_on 'Todas as cartas'
    click_on 'Lobisomem'
    click_on 'Excluir'

    expect(current_path).to eq cards_path
    expect(page).not_to have_css('h4', text: 'Lobisomem')
    expect(page).to have_css('h4', text: 'Guerreiro')

  end

end
