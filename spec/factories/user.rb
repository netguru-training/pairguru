FactoryBot.define do
  trait :user_base do
    sequence(:email) { |n| "user#{n}@example.com" }
    name { Faker::Name.name }
    password { "password" }
    password_confirmation { password.to_s }
  end

  factory :user, traits: [:user_base]
end