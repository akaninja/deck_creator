FactoryBot.define do
  factory :card do
    sequence(:name) {|n| "Carta #{n}"}
    faction
    card_type
    user
    play_cost { "3" }
    description { "Descrição padrão de carta aleatória." } 
  end
end