FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.paragraph }
    user
    movie
  end

end
