FactoryBot.define do
  factory :comment do
    description { Faker::Lorem.sentence(3, true) }
    user
    movie
  end
end
