require 'rails_helper'

feature 'User highlights cards' do
  scenario 'successfully' do
  
    card_type1 = CardType.create(name: 'Magia')
    card_type2 = CardType.create(name: 'Encantamento')
    faction1 = Faction.create(name: 'Ruby')
    faction2 = Faction.create(name: 'Javascript')
    Card.create(name: 'Lobisomem', card_type: card_type1, faction: faction1, play_cost: '3', 
                description: 'Uivos terríveis...', highlight: false)
    Card.create(name: 'Escudo', card_type: card_type2, faction: faction2, play_cost: '4', 
                description: 'Fiel escueiro.', highlight: false)
    Card.create(name: 'Bola de fogo', card_type: card_type1, faction: faction1, play_cost: '6', 
                description: 'Alô, quem é?', highlight: false)
    Card.create(name: 'Guerreiro', card_type: card_type2, faction: faction2, play_cost: '7', 
                description: 'Meu herói....', highlight: false)
    Card.create(name: 'Chuva de Gelo', card_type: card_type1, faction: faction1, play_cost: '10', 
                description: 'Também conhecido como granizo.',highlight: false)
    Card.create(name: 'Rei', card_type: card_type1, faction: faction1, play_cost: '9', 
                description: 'Monarca.', highlight: false)
    Card.create(name: 'Bobo da corte', card_type: card_type1, faction: faction1, play_cost: '11', 
                description: 'Palhaço da hora.', highlight: false)
    Card.create(name: 'Algemas', card_type: card_type1, faction: faction2, play_cost: '3', 
                description: 'Eu fui um menino muito mal...', highlight: false)

    visit root_path
    click_on 'Todas as cartas'
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
    card_type1 = CardType.create(name: 'Magia')
    faction1 = Faction.create(name: 'Ruby')
    card = Card.create(name: 'Lobisomem', card_type: card_type1, faction: faction1, play_cost: '3', 
                description: 'Uivos terríveis...')

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
    card_type1 = CardType.create(name: 'Magia')
    faction1 = Faction.create(name: 'Ruby')
    card = Card.create(name: 'Lobisomem', card_type: card_type1, faction: faction1, play_cost: '3', 
                description: 'Uivos terríveis...')

    card.update(highlight: true)            
    
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
