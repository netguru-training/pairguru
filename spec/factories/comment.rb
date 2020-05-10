FactoryBot.define do
  factory :comment do
    created_at {Time.now}
    body {"Comment body"}
    user
    movie
  end
end
