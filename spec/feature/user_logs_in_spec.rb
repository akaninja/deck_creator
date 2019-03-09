require 'rails_helper'

feature 'User logs in' do
  scenario 'successfully' do
    
    User.create(email: 'usuario@hotmail.com', password: '123456')

    visit root_path
    click_on  'Entrar'
    fill_in 'Email', with: 'usuario@hotmail.com'
    fill_in 'Senha', with: '123456'
    click_on 'Enviar'

    expect(current_path).to eq root_path
    expect(page).to have_css('p', text: 'Bem vindo, usuario@hotmail.com.')
  end

  scenario 'and enters wrong information' do
        
    User.create(email: 'usuario@hotmail.com', password: '123456')

    visit root_path
    click_on  'Entrar'
    fill_in 'Email', with: 'apolonio@gmail.com'
    fill_in 'Senha', with: '7655443'
    click_on 'Enviar'

    expect(current_path).to eq user_session_path
    expect(page).to have_content('Email')
    expect(page).to have_content('Senha')
  end

  scenario 'and logs out successfully' do
    user = User.create(email: 'usuario@hotmail.com', password: '123456')
    login_as user, :scope => :user  
    
    visit root_path
    click_on 'Sair'

    expect(current_path).to eq root_path
    expect(page).to have_css('p', text: 'Entrar')
  end


end
