require 'rails_helper'

feature 'Admin highlights cards' do
  scenario 'successfully' do
  
    card_type1 = create(:card_type, name: 'Magia')
    card_type2 =  create(:card_type, name: 'Encantamento')
    faction1 = create(:faction, name: 'Ruby')
    faction2 = create(:faction, name: 'Javascript')

    admin = create(:admin)

    create(:card, name: 'Lobisomem', card_type: card_type1, faction: faction1, play_cost: '3', 
                description: 'Uivos terríveis...', highlight: false, admin: admin)
    create(:card, name: 'Escudo', card_type: card_type2, faction: faction2, play_cost: '4', 
                description: 'Fiel escueiro.', highlight: false, admin: admin)
    create(:card, name: 'Bola de fogo', card_type: card_type1, faction: faction1, play_cost: '6', 
                description: 'Alô, quem é?', highlight: false, admin: admin)
    create(:card, name: 'Guerreiro', card_type: card_type2, faction: faction2, play_cost: '7', 
                description: 'Meu herói....', highlight: false, admin: admin)
    create(:card, name: 'Chuva de Gelo', card_type: card_type1, faction: faction1, play_cost: '10', 
                description: 'Também conhecido como granizo.',highlight: false, admin: admin)
    create(:card, name: 'Rei', card_type: card_type1, faction: faction1, play_cost: '9', 
                description: 'Monarca.', highlight: false, admin: admin)
    create(:card, name: 'Bobo da corte', card_type: card_type1, faction: faction1, play_cost: '11', 
                description: 'Palhaço da hora.', highlight: false, admin: admin)
    create(:card, name: 'Algemas', card_type: card_type1, faction: faction2, play_cost: '3', 
                description: 'Eu fui um menino muito mal...', highlight: false, admin: admin)

    login_as admin, scope: :admin                

    visit root_path
    click_on 'Cartas'
    click_on 'Lobisomem'  
    click_on 'Destacar'
    click_on 'Home'

    expect(current_path).to eq root_path
    within 'div.highlight' do
      expect(page).to have_css('h3', text: 'Lobisomem')
      expect(page).not_to have_css('h3', text: 'Escudo')
    end
  end

  scenario 'and Highlight button changes to unhighlight' do
    card_type1 = create(:card_type, name: 'Magia')
    faction1 = create(:faction, name: 'Ruby')
    admin = create(:admin)
    card = create(:card, name: 'Lobisomem', card_type: card_type1, faction: faction1, play_cost: '3', 
                description: 'Uivos terríveis...', highlight: false, admin: admin)

    login_as admin, scope: :admin

    visit card_path(1)
    click_on 'Destacar'

    #atualizar banco de dados
    card.reload

    expect(current_path).to eq card_path(1)
    expect(card.highlight).to eq true
    expect(page).not_to have_css('p', text: 'Destacar')
    expect(page).to have_css('p', text: 'Remover destaque')

  end

  scenario 'and unhighlights it successfully' do
    card_type1 = create(:card_type, name: 'Magia')
    faction1 = create(:faction, name: 'Ruby')
    admin = create(:admin)
    card = create(:card, name: 'Lobisomem', card_type: card_type1, faction: faction1, play_cost: '3', 
                description: 'Uivos terríveis...', highlight: false, admin: admin)

    card.update(highlight: true)            
    
    login_as admin, scope: :admin

    visit card_path(1)
    click_on 'Remover destaque'

    #atualizar banco de dados
    card.reload
    
    expect(current_path).to eq card_path(1)
    expect(card.highlight).to eq false
    expect(page).not_to have_css('p', text: 'Remover destaque')
    expect(page).to have_css('p', text: 'Destacar')
  end

end
