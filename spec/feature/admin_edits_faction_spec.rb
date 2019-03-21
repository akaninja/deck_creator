require 'rails_helper'

feature 'Admin edits faction' do 
  scenario 'successfully' do

    admin = create(:admin)
    Faction.create(name: 'Ruby')

    login_as admin, :scope => :admin

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
    admin = create(:admin)
    Faction.create(name: 'Ruby')
    login_as admin, :scope => :admin

    visit root_path
    click_on 'Facções'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Não foi possível atualizar a facção')
  end

  scenario 'and deletes a faction' do

    admin = create(:admin)
    Faction.create(name: 'Ruby')
    login_as admin, :scope => :admin

    visit root_path
    click_on 'Facções'
    click_on 'Excluir'
    
    expect(current_path).to eq factions_path
    expect(page).not_to have_css('li', text: 'Ruby')
    
  end

  scenario 'and must be admin' do
    
    user = create(:user)

    login_as user, :scope => :user

    visit factions_path

    expect(current_path).to eq new_admin_session_path

  end

  scenario 'deletes a factions and removes several cards' do

    card_type1 = CardType.create(name: 'Magia')
    card_type2 = CardType.create(name: 'Encantamento')
    faction1 = Faction.create(name: 'Ruby')
    faction2 = Faction.create(name: 'Javascript')

    admin = Admin.create!(name: 'João', email: 'user@email.com', password: '123456')

    Card.create!(name: 'Lobisomem', card_type: card_type1, faction: faction1, play_cost: '6', 
                description: 'Auuuuuuuuuu...', admin: admin)
    Card.create!(name: 'Bola de fogo', card_type: card_type2, faction: faction2, play_cost: '4', 
                description: 'Quem é?', admin: admin)
    Card.create!(name: 'Chuva de gelo', card_type: card_type1, faction: faction1, play_cost: '6', 
                description: 'Diacho...', admin: admin)
    Card.create!(name: 'Guerreiro', card_type: card_type2, faction: faction2, play_cost: '4', 
                description: 'Gemidos terríveis...', admin: admin)
    Card.create!(name: 'Lago espelhado', card_type: card_type1, faction: faction1, play_cost: '6', 
                description: 'Quem é o mais delício?', admin: admin)

    faction1.destroy
    cards = Card.all.length

    expect(cards).to eq 2

  end
end
