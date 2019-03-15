FactoryBot.define do
  factory :card_type do
    sequence(:name) { |n| "Tipo de carta#{n}" }
  end
end