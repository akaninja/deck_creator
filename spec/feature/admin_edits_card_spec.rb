require 'rails_helper'

feature 'User edits card info' do
  scenario 'successfully' do
    card_type1 = create(:card_type, name: 'Magia')
    card_type2 = create(:card_type, name: 'Encantamento')
    faction1 = create(:faction, name: 'Ruby')
    faction2 = create(:faction, name: 'Javascript')
    admin = create(:admin, name: 'João', email: 'user@email.com', password: '123456')
    card1 = create(:card, name: 'Lobisomem', card_type: card_type1, faction: faction1, play_cost: '6', description: 'Uivos terríveis...', admin: admin)
    card2 = create(:card, name: 'Guerreiro', card_type: card_type2, faction: faction2, play_cost: '4', description: 'Gemidos terríveis...', admin: admin)

    login_as admin, scope: :admin

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
    card_type1 = create(:card_type, name: 'Magia')
    faction1 = create(:faction, name: 'Ruby')
    admin = create(:admin)
    card1 = create(:card, name: 'Lobisomem', card_type: card_type1, faction: faction1, play_cost: '6', description: 'Uivos terríveis...', admin: admin)

    login_as admin, scope: :admin

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
    card_type1 = create(:card_type, name: 'Magia')
    card_type2 = create(:card_type, name: 'Encantamento')
    faction1 = create(:faction, name: 'Ruby')
    faction2 = create(:faction, name: 'Javascript')
    admin = create(:admin)
    card1 = create(:card, name: 'Lobisomem', card_type: card_type1, faction: faction1, play_cost: '6', description: 'Uivos terríveis...', admin: admin)
    card2 = create(:card, name: 'Guerreiro', card_type: card_type2, faction: faction2, play_cost: '4', description: 'Gemidos terríveis...', admin: admin)
    
    login_as admin, scope: :admin

    visit  cards_path
    click_on 'Lobisomem'
    click_on 'Excluir'

    expect(current_path).to eq cards_path
    expect(page).not_to have_css('h4', text: 'Lobisomem')
    expect(page).to have_css('h4', text: 'Guerreiro')

  end

  scenario 'and uploads image art successfully' do

    card_type1 = create(:card_type, name: 'Magia')
    card_type2 = create(:card_type, name: 'Encantamento')
    faction1 = create(:faction, name: 'Ruby')
    faction2 = create(:faction, name: 'Javascript')
    admin = create(:admin, email: 'user@email.com', password: '123456')
    card1 = create(:card, name: 'Lobisomem', card_type: card_type1, faction: faction1, play_cost: '6', description: 'Uivos terríveis...', admin: admin)

    login_as admin, scope: :admin

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

  scenario 'and must be admin' do

    user = create(:user)
    card = create(:card)
    login_as user, scope: :user

    visit edit_card_path(card)

    expect(current_path).to eq new_admin_session_path
  end

  scenario 'must be admin and cant see edit card button' do
    
    user = create(:user, email: 'user@email.com', password: '123456')

    card1 = create(:card)

    login_as user, :scope => :user

    visit card_path(card1)

    expect(current_path).to eq card_path(card1)
    expect(page).not_to have_css('Editar')
    expect(page).not_to have_css('Excluir')
    expect(page).not_to have_css('Destacar')

  end

end
