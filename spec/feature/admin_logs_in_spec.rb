require 'rails_helper'

feature 'Admin logs in' do
  scenario 'successfully' do

    admin = create(:admin, name: 'João', email:'joao@email.com', password: '123456')

    visit root_path
    click_on 'Entrar como administrador'
    fill_in 'Email', with: 'joao@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Enviar'

    expect(current_path).to eq root_path
    expect(page).to have_content('Bem vindo, João.')

  end

  scenario 'and must fill all fields' do

    admin = create(:admin, name: 'João', email:'joao@email.com', password: '123456')

    visit new_admin_session_path
    fill_in 'Email', with: ''
    fill_in 'Senha', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Email ou senha inválida.')

  end

end
