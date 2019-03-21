require 'rails_helper'

feature 'Admin creates faction' do 
  scenario 'successfully' do
    
    admin = Admin.create(name: 'Joao', email: 'joao@email.com', password: '123456')

    Faction.create(name: 'Javascript')
    Faction.create(name: 'CSharp')
    Faction.create(name: 'Python')

    login_as admin, :scope => :admin

    visit root_path
    click_on 'Facções'
    click_on 'Criar facção'
    fill_in 'Nome', with: 'Ruby'
    click_on 'Enviar'

    expect(current_path).to eq factions_path
    expect(page).to have_css('h1', text: 'Facções')
    expect(page).to have_css('li', text: 'Ruby')
    expect(page).to have_css('li', text: 'Javascript')
    expect(page).to have_css('li', text: 'CSharp')
    expect(page).to have_css('li', text: 'Python')

  end

  scenario 'and must fill in Name' do

    admin = Admin.create(name: 'Joao', email: 'joao@email.com', password: '123456')
    login_as admin, :scope => :admin

    visit root_path
    click_on 'Facções'
    click_on 'Criar facção'
    fill_in 'Nome', with: ''
    click_on 'Enviar'
    
    expect(page).to have_content('Não foi possível salvar a facção')
    
  end

  scenario 'and must have unique name' do
    Faction.create(name: 'Ruby')
    admin = Admin.create(name: 'Joao', email: 'joao@email.com', password: '123456')
    login_as admin, :scope => :admin

    visit root_path
    click_on 'Facções'
    click_on 'Criar facção'
    fill_in 'Nome', with: 'Ruby'
    click_on 'Enviar'

    expect(page).to have_content('Não foi possível salvar a facção')

  end

  scenario 'and must be loged in' do
    
    visit root_path

    expect(page).not_to have_css('p', text: 'Facções')

  
  end

  scenario 'and must be admin' do

    user = create(:user)
    login_as user, :scope => :user

    visit root_path 

    expect(page).not_to have_css('p', text: 'Facções')

  end

end