FactoryBot.define do
  factory :user do
    sequence(:email)      { |n| "user#{n}@example.com" }
    password              { 'Password123' }
    password_confirmation { 'Password123' }
    confirmed_at          { 1.day.ago }
  end
end
