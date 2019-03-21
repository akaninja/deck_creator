require 'rails_helper'

feature 'User creates a deck of cards' do
  scenario 'successfully' do
    
    user = create(:user, email: 'user@email.com', password: '123456')
    deck = Deck.create(name: 'Deck de demônios', private: false, user: user)

    login_as user, scope: :user
    visit root_path
    click_on 'Decks'
    click_on 'Criar deck'
    fill_in 'Nome', with: 'Deck de monstros'
    click_on 'Enviar'

    expect(current_path).to eq decks_path
    expect(page).to have_css('li', text: 'Deck de monstros')
    expect(page).to have_css('li', text: 'Deck de demônios')

  end

  scenario 'and and must fill in Name' do
    user = create(:user, email: 'user@email.com', password: '123456')

    login_as user, scope: :user
    visit decks_path
    click_on 'Criar deck'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Não foi possível criar o deck')
  end

  scenario 'and adds card to deck' do
    card_type1 = create(:card_type, name: 'Magia')
    card_type2 = create(:card_type, name: 'Encantamento')
    faction1 = create(:faction, name: 'Ruby')
    faction2 = create(:faction, name: 'Javascript')
    user = create(:user, email: 'user@email.com', password: '123456')
    card1 = create(:card, name: 'Lobisomem', card_type: card_type1, faction: faction1, play_cost: '6', description: 'Uivos terríveis...')
    card2 = create(:card, name: 'Guerreiro', card_type: card_type2, faction: faction2, play_cost: '4', description: 'Gemidos terríveis...')

    deck = create(:deck, name: 'Deck de demônios', private: false, user: user)
    
    login_as user, scope: :user

    visit root_path
    click_on 'Cartas'
    click_on 'Lobisomem'
    select 'Deck de demônios', from: 'Decks'
    click_on 'Adicionar ao deck'

    expect(current_path).to eq cards_path
    expect(page).to have_content('Carta adicionada ao Deck: Deck de demônios')
  end

  scenario 'adds card to deck, then views deck list' do
    card_type1 = create(:card_type, name: 'Magia')
    card_type2 = create(:card_type, name: 'Encantamento')
    faction1 = create(:faction, name: 'Ruby')
    faction2 = create(:faction, name: 'Javascript')
    user = create(:user, email: 'user@email.com', password: '123456')
    card1 = create(:card, name: 'Lobisomem', card_type: card_type1, faction: faction1, play_cost: '6', description: 'Uivos terríveis...')
    card2 = create(:card, name: 'Guerreiro', card_type: card_type2, faction: faction2, play_cost: '4', description: 'Gemidos terríveis...')

    deck = Deck.create!(name: 'Deck de demônios', private: false, user: user)
    
    login_as user, scope: :user

    visit cards_path
    click_on 'Lobisomem'
    select 'Deck de demônios', from: 'Decks'
    click_on 'Adicionar ao deck'
    click_on 'Decks'
    click_on 'Deck de demônios'

    expect(page).to have_css('p', text:'Lobisomem')
  end

  scenario 'and sets it to Private' do
    user = create(:user, email: 'user@email.com', password: '123456')

    login_as user, scope: :user
    visit root_path
    click_on 'Decks'
    click_on 'Criar deck'
    fill_in 'Nome', with: 'Deck de monstros'
    page.check('Privado')
    click_on 'Enviar'

    deck = Deck.last

    expect(deck.private).to eq true

  end

  scenario 'and private deck is not visible to others' do
    user = create(:user, email: 'user@email.com', password: '123456')
    create(:deck, name: 'Deck de demônios', private: true, user: user)
    create(:deck, name: 'Deck de flores', private: false, user: user)
  
    visit root_path
    click_on 'Decks'
    
    expect(page).to have_css('li', text: 'Deck de flores')
    expect(page).not_to have_css('li', text: 'Deck de demônios')

  end

  scenario 'and views his decks in My decks page' do
    user = create(:user, email: 'user@email.com', password: '123456')
    user2 = create(:user, email: 'user2@email.com', password: '123456')
    create(:deck, name: 'Deck de demônios', private: true, user: user)
    create(:deck, name: 'Deck de flores', private: false, user: user)
    create(:deck, name: 'Deck de goiabas', private: false, user: user2)

    login_as user, scope: :user
    visit root_path
    click_on 'Decks'
    click_on 'Meus decks'
    
    expect(current_path).to eq my_decks_path
    expect(page).to have_css('li', text: 'Deck de flores')
    expect(page).to have_css('li', text: 'Deck de demônios')
    expect(page).not_to have_css('li', text: 'Deck de goiabas')

  end

end