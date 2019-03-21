require 'rails_helper'

feature 'Visitor creates new user account' do
  scenario 'successfully' do
    
    visit root_path
    click_on 'Novo usuário'
    fill_in 'Nome', with: 'Andre'
    fill_in 'Email', with: 'andre@email.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmar senha', with: '123456'
    click_on 'Enviar'

    expect(current_path).to eq root_path
    expect(page).to have_css('p', text: 'Bem vindo, Andre.')
  end

  scenario 'and fills in wrong password confirmation' do
    
    visit root_path
    click_on 'Novo usuário'
    fill_in 'Nome', with: 'Andre'
    fill_in 'Email', with: 'andre@email.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmar senha', with: 'qwerty'
    click_on 'Enviar'

    expect(page).to have_content('Email')
    expect(page).to have_content('Senha')
    expect(page).to have_content('Confirmar senha')
  end

end