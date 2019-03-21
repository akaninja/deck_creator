# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
    
    card_type1 = CardType.create(name: 'Magia')
    card_type2 = CardType.create(name: 'Encantamento')
    faction1 = Faction.create(name: 'Ruby')
    faction2 = Faction.create(name: 'Javascript')

    admin = Admin.create(name: 'João', email: 'admin@email.com', password: '123456')
    admin2 = Admin.create(name: 'João2', email: 'admin2@email.com', password: '123456')
    user = User.create(name: 'Vini', email: 'user@email.com', password: '123456')
    user2 = User.create(name: 'Vini2', email: 'user2@email.com', password: '123456')

    Card.create(name: 'Lobisomem', card_type: card_type1, faction: faction1, play_cost: '3', 
                description: 'Uivos terríveis...', admin: admin)
    Card.create(name: 'Escudo', card_type: card_type2, faction: faction2, play_cost: '4', 
                description: 'Fiel escueiro.', admin: admin)
    Card.create(name: 'Bola de fogo', card_type: card_type1, faction: faction1, play_cost: '6', 
                description: 'Alô, quem é?', admin: admin)
    Card.create(name: 'Guerreiro', card_type: card_type2, faction: faction2, play_cost: '7', 
                description: 'Meu herói....', admin: admin)
    Card.create(name: 'Chuva de Gelo', card_type: card_type1, faction: faction1, play_cost: '10', 
                description: 'Também conhecido como granizo.',admin: admin2)
    Card.create(name: 'Rei', card_type: card_type1, faction: faction1, play_cost: '9', 
                description: 'Monarca.', admin: admin2)
    Card.create(name: 'Bobo da corte', card_type: card_type1, faction: faction1, play_cost: '11', 
                description: 'Palhaço da hora.', admin: admin2)
    Card.create(name: 'Algemas', card_type: card_type1, faction: faction2, play_cost: '3', 
                description: 'Eu fui um menino muito mal...', admin: admin2)
                