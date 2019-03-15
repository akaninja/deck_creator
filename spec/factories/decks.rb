FactoryBot.define do
  factory :deck do
    sequence(:name) {|n| "Deck #{n}"}
    user
  end
end