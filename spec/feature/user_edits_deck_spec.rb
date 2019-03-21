require 'rails_helper'

feature 'User edits deck' do
  scenario 'and removes a card' do

    user = create(:user)
    card = create(:card)
    deck = create(:deck, user: user)
    DeckCard.create(deck: deck, card: card)

    login_as user, scope: :user

    visit deck_path(deck.id)
    click_on 'Remover carta'

    expect(current_path).to eq deck_path(deck.id)
    expect(page).not_to have_content(card.name)

  end

  scenario 'and deletes deck' do 
    
    user = create(:user)
    card = create(:card)
    deck = create(:deck, user: user)
    DeckCard.create(deck: deck, card: card)

    login_as user, scope: :user

    visit deck_path(deck.id)
    click_on 'Excluir deck'

    expect(current_path).to eq decks_path
    expect(page).not_to have_content(deck.name)

  end

  scenario 'and renames de deck' do
  
    user = create(:user)
    card = create(:card)
    deck = create(:deck, user: user)
    DeckCard.create(deck: deck, card: card)

    login_as user, :scope => :user

    visit deck_path(deck.id)
    click_on 'Renomear deck'
    fill_in 'Nome', with: 'Novo nome'
    page.check('Privado')
    click_on 'Enviar'

    expect(current_path).to eq deck_path(deck.id)
    expect(page).to have_content('Novo nome')

  end
end
