require 'rails_helper'

feature 'User edits card info' do
  scenario 'successfully' do
    card_type1 = CardType.create(name: 'Magia')
    card_type2 = CardType.create(name: 'Encantamento')
    faction1 = Faction.create(name: 'Ruby')
    faction2 = Faction.create(name: 'Javascript')
    user = User.create!(email: 'user@email.com', password: '123456')
    card1 = Card.create!(name: 'Lobisomem', card_type: card_type1, faction: faction1, play_cost: '6', description: 'Uivos terríveis...', user: user)
    card2 = Card.create!(name: 'Guerreiro', card_type: card_type2, faction: faction2, play_cost: '4', description: 'Gemidos terríveis...', user: user)

    login_as user, :scope => :user

    visit root_path
    click_on 'Cartas'
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
    user = User.create!(email: 'user@email.com', password: '123456')
    card1 = Card.create!(name: 'Lobisomem', card_type: card_type1, faction: faction1, play_cost: '6', description: 'Uivos terríveis...', user: user)

    login_as user, :scope => :user

    visit cards_path
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
    user = User.create!(email: 'user@email.com', password: '123456')
    card1 = Card.create!(name: 'Lobisomem', card_type: card_type1, faction: faction1, play_cost: '6', description: 'Uivos terríveis...', user: user)
    card2 = Card.create(name: 'Guerreiro', card_type: card_type2, faction: faction2, play_cost: '4', description: 'Gemidos terríveis...', user: user)
    
    login_as user, :scope => :user

    visit  cards_path
    click_on 'Lobisomem'
    click_on 'Excluir'

    expect(current_path).to eq cards_path
    expect(page).not_to have_css('h4', text: 'Lobisomem')
    expect(page).to have_css('h4', text: 'Guerreiro')

  end

  scenario 'and uploads image art successfully' do

    card_type1 = CardType.create(name: 'Magia')
    card_type2 = CardType.create(name: 'Encantamento')
    faction1 = Faction.create(name: 'Ruby')
    faction2 = Faction.create(name: 'Javascript')
    user = User.create!(email: 'user@email.com', password: '123456')
    card1 = Card.create!(name: 'Lobisomem', card_type: card_type1, faction: faction1, play_cost: '6', description: 'Uivos terríveis...', user: user)

    login_as user, :scope => :user

    visit  cards_path
    click_on 'Lobisomem'
    click_on 'Editar'

    select 'Javascript', from: 'Facção'
    fill_in 'Nome', with: 'Selo contra Lobisomem'
    fill_in 'Custo', with: '5'
    select 'Encantamento', from: 'Tipo'
    fill_in 'Descrição', with: 'Vira, vira, vira homem... vira, vira lobisomem'
    attach_file 'Imagem', Rails.root.join('spec', 'support', 'warrior.jpg')
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Selo contra Lobisomem')
    expect(page).to have_css('h3', text: 'Javascript')
    expect(page).to have_css('p', text: '5 mana')
    expect(page).to have_css('p', text: 'Encantamento')
    expect(page).to have_css('p', text: 'Vira, vira, vira homem... vira, vira lobisomem')
    expect(page).to have_css('img[src*="warrior.jpg"]')

  end

  scenario 'and cant see edit button' do
    
    card_type1 = CardType.create(name: 'Magia')
    card_type2 = CardType.create(name: 'Encantamento')
    faction1 = Faction.create(name: 'Ruby')
    faction2 = Faction.create(name: 'Javascript')

    user = User.create!(email: 'user@email.com', password: '123456')
    user2 = User.create!(email: 'user2@email.com', password: '789101')

    card1 = Card.create!(name: 'Lobisomem', card_type: card_type1, faction: faction1, play_cost: '6', description: 'Uivos terríveis...', user: user2)
    card2 = Card.create!(name: 'Guerreiro', card_type: card_type2, faction: faction2, play_cost: '4', description: 'Gemidos terríveis...', user: user2)

    login_as user, :scope => :user

    visit cards_path
    click_on 'Lobisomem'

    expect(current_path).to eq card_path(1)
    expect(page).not_to have_css('p', text: 'Editar')
    expect(page).not_to have_css('p', text: 'Excluir')
    expect(page).not_to have_css('p', text: 'Destacar')

  end

  scenario 'by direct root path and must be card owner' do
    
    card_type1 = CardType.create(name: 'Magia')
    card_type2 = CardType.create(name: 'Encantamento')
    faction1 = Faction.create(name: 'Ruby')
    faction2 = Faction.create(name: 'Javascript')

    user = User.create!(email: 'user@email.com', password: '123456')
    user2 = User.create!(email: 'user2@email.com', password: '789101')

    card1 = Card.create!(name: 'Lobisomem', card_type: card_type1, faction: faction1, play_cost: '6', description: 'Uivos terríveis...', user: user2)
    card2 = Card.create!(name: 'Guerreiro', card_type: card_type2, faction: faction2, play_cost: '4', description: 'Gemidos terríveis...', user: user2)

    login_as user, :scope => :user

    visit edit_card_path(1)

    expect(current_path).to eq cards_path
    expect(page).not_to have_css('Editar')
    expect(page).not_to have_css('Excluir')
    expect(page).not_to have_css('Destacar')

  end

end
