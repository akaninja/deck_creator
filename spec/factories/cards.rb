FactoryBot.define do
  factory :card do
    sequence(:name) {|n| "Carta #{n}"}
    faction
    card_type
    admin
    play_cost { "3" }
    description { "Descrição padrão de carta aleatória." } 
    highlight {false}
  end
end