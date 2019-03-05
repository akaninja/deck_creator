require 'rails_helper'

feature 'User creates card' do 
  scenario 'successfully' do

    Faction.create(name: 'Ruby')
    CardType.create(name: 'Criatura')

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

  end

  scenario 'and must fill all fields' do

    Faction.create(name: 'Ruby')
    CardType.create(name: 'Criatura')

    visit root_path
    click_on 'Criar carta'
    fill_in 'Nome', with: ''
    fill_in 'Custo', with: ''
    fill_in 'Descrição', with: ''
    click_on 'Enviar'

    #expect(current_path).to eq new_card_path
    expect(page).to have_content('Não foi possível salvar a carta')
  end

end
