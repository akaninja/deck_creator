require 'rails_helper'

feature 'User creates card' do 
  scenario 'successfully' do

    user = User.create!(email: 'user@email.com', password: '123456')
    Faction.create!(name: 'Ruby')
    CardType.create!(name: 'Criatura')

    login_as user, :scope => :user

    visit root_path
    click_on 'Criar carta'
    select 'Ruby', from: 'Facção'
    fill_in 'Nome', with: 'Lobisomem'
    fill_in 'Custo', with: '5'
    select 'Criatura', from: 'Tipo'
    fill_in 'Descrição', with: 'Vira, vira, vira homem... vira, vira lobisomem'
    click_on 'Enviar'

    expect(current_path).to eq card_path(1)
    expect(page).to have_css('h1', text: 'Lobisomem')
    expect(page).to have_css('h3', text: 'Ruby')
    expect(page).to have_css('p', text: '5 mana')
    expect(page).to have_css('p', text: 'Criatura')
    expect(page).to have_css('p', text: 'Vira, vira, vira homem... vira, vira lobisomem')
    expect(page).to have_css('p', text: 'Carta criada por user@email.com')

  end

  scenario 'and must fill all fields' do

    Faction.create(name: 'Ruby')
    CardType.create(name: 'Criatura')
    user = User.create!(email: 'user@email.com', password: '123456')
    login_as user, :scope => :user
    
    visit root_path
    click_on 'Criar carta'
    fill_in 'Nome', with: ''
    fill_in 'Custo', with: ''
    fill_in 'Descrição', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Não foi possível salvar a carta')
  end

  scenario 'and play cost must be positive' do

    Faction.create(name: 'Ruby')
    CardType.create(name: 'Criatura')
    user = User.create!(email: 'user@email.com', password: '123456')
    login_as user, :scope => :user

    visit root_path
    click_on 'Criar carta'
    select 'Ruby', from: 'Facção'
    fill_in 'Nome', with: 'Lobisomem'
    fill_in 'Custo', with: '-5'
    select 'Criatura', from: 'Tipo'
    fill_in 'Descrição', with: 'Vira, vira, vira homem... vira, vira lobisomem'
    click_on 'Enviar'

    expect(page).to have_content('Não foi possível salvar a carta')
    
  end
  
  scenario 'and name must be unique' do
    user = User.create!(email: 'user@email.com', password: '123456')
    user2 = User.create!(email: 'user2@email.com', password: '789101')
    faction = Faction.create(name: 'Ruby')
    card_type = CardType.create(name: 'Criatura')
    card = Card.create!(name: 'Lobisomem', faction: faction, card_type: card_type, play_cost: '5', description: "Descrição", user: user2)

    login_as user, :scope => :user

    visit root_path
    click_on 'Criar carta'
    select 'Ruby', from: 'Facção'
    fill_in 'Nome', with: 'Lobisomem'
    fill_in 'Custo', with: '5'
    select 'Criatura', from: 'Tipo'
    fill_in 'Descrição', with: 'Vira, vira, vira homem... vira, vira lobisomem'
    click_on 'Enviar'

    expect(page).to have_content('Não foi possível salvar a carta')
  end

  scenario 'and uploads a art successfully' do 
  
    Faction.create(name: 'Ruby')
    CardType.create(name: 'Criatura')

    #user = User.create!(email: 'user@email.com', password: '123456')
    user = create(:user)

    login_as user, :scope => :user

    visit root_path
    click_on 'Criar carta'
    select 'Ruby', from: 'Facção'
    fill_in 'Nome', with: 'Lobisomem'
    fill_in 'Custo', with: '5'
    select 'Criatura', from: 'Tipo'
    fill_in 'Descrição', with: 'Vira, vira, vira homem... vira, vira lobisomem'
    attach_file 'Imagem', Rails.root.join('spec', 'support', 'warrior.jpg')
    click_on 'Enviar'

    expect(current_path).to eq card_path(1)
    expect(page).to have_css('h1', text: 'Lobisomem')
    expect(page).to have_css('h3', text: 'Ruby')
    expect(page).to have_css('p', text: '5 mana')
    expect(page).to have_css('p', text: 'Criatura')
    expect(page).to have_css('p', text: 'Vira, vira, vira homem... vira, vira lobisomem')
    expect(page).to have_css('img[src*="warrior.jpg"]')

  end

  scenario 'and must be logged in' do
    
    visit root_path
    click_on 'Criar carta'

    expect(current_path).to eq user_session_path
    expect(page).to have_content('Email')
    expect(page).to have_content('Senha')

  end


end
