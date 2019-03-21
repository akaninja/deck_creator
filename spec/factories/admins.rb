FactoryBot.define do
  factory :admin do
    sequence(:name) { |n| "João#{n}" }
    sequence(:email) { |n| "joao#{n}@email.com"}
    password { '1234567' }
    
  end
end
