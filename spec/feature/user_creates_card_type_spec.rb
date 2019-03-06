require 'rails_helper'

feature 'User creates card type' do 
  scenario 'successfully' do
   
    CardType.create(name: 'Encantamento')
    CardType.create(name: 'Magia')

    visit root_path
    click_on 'Tipos'
    click_on 'Criar tipo'
    fill_in 'Nome', with: 'Criatura'
    click_on 'Enviar'

    expect(current_path).to eq card_types_path
    expect(page).to have_css('h1', text: 'Tipos')
    expect(page).to have_css('li', text: 'Encantamento')
    expect(page).to have_css('li', text: 'Magia')
    expect(page).to have_css('li', text: 'Criatura')

  end

  scenario 'and must fill all fields' do
    
    visit root_path
    click_on 'Tipos'
    click_on 'Criar tipo'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Não foi possível salvar o tipo')

  end

  scenario 'and must have unique name' do

    CardType.create(name: 'Criatura')
    
    visit root_path
    click_on 'Tipos'
    click_on 'Criar tipo'
    fill_in 'Nome', with: 'Criatura'
    click_on 'Enviar'

    expect(current_path).to eq card_types_path
    expect(page).to have_content('Não foi possível salvar o tipo')


  end

end
