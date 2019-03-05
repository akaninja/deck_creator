require 'rails_helper'

feature 'User creates faction' do 
  scenario 'successfully' do
    
    Faction.create(name: 'Javascript')
    Faction.create(name: 'CSharp')
    Faction.create(name: 'Python')

    visit root_path
    click_on 'Facções'
    click_on 'Criar facção'
    fill_in 'Nome', with: 'Ruby'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Facções')
    expect(page).to have_css('h2', text: 'Ruby')
    expect(page).to have_css('h2', text: 'Javascript')
    expect(page).to have_css('h2', text: 'CSharp')
    expect(page).to have_css('h2', text: 'Python')

  end

  scenario 'and must fill in Name' do

    visit root_path
    click_on 'Facções'
    click_on 'Criar facção'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Não foi possível salvar a facção')
    
  end

end