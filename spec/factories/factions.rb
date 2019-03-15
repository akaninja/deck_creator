FactoryBot.define do
  factory :faction do
    sequence(:name) { |n| "Facção padrão #{n}" }
  end
end