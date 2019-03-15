FactoryBot.define do
  factory :user do
    sequence(:email) {|n| "joao#{n}@mail.com"}
    password {"123456"}
  end
end