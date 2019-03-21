require 'rails_helper'

feature 'Admin creates card type' do 
  scenario 'successfully' do
   
    admin = create(:admin)

    CardType.create(name: 'Encantamento')
    CardType.create(name: 'Magia')

    login_as admin, :scope => :admin

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
       
    admin = create(:admin)

    login_as admin, :scope => :admin
    
    visit root_path
    click_on 'Tipos'
    click_on 'Criar tipo'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Não foi possível salvar o tipo')

  end

  scenario 'and must have unique name' do

    CardType.create(name: 'Criatura')
    admin = create(:admin)

    login_as admin, :scope => :admin
    
    visit root_path
    click_on 'Tipos'
    click_on 'Criar tipo'
    fill_in 'Nome', with: 'Criatura'
    click_on 'Enviar'

    expect(current_path).to eq card_types_path
    expect(page).to have_content('Não foi possível salvar o tipo')


  end

  scenario 'must be admin and cant see Create card type button' do
    
    user = create(:user)

    login_as user, scope: :user

    visit root_path
    
    expect(page).not_to have_css('p', text: 'Tipos')

  end

  scenario 'must be admin' do
    user = create(:user)

    login_as user, scope: :user

    visit new_card_type_path
    
    expect(current_path).to eq new_admin_session_path

  end

end
