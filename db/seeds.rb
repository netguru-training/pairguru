require 'faker'

puts 'Creating users...'
User.create!(
  email: 'user@example.com',
  password: 'userexample11'
) unless User.find_by(email: 'user@example.com')

20.times do
  User.create!(
    email: Faker::Internet.email,
    password: 'commonpass11'
  )
end

puts 'Creating genres...'
%w(Action Comedy Sci-Fi War Crime
   Horror Sport Western Drama
   Musicial Romance Thriller
).each do |genre|
  Genre.find_or_create_by!(name: genre)
end

puts 'Creating movies...'
genre_ids = Genre.pluck(:id)
100.times do
  title_how_many_words = [1, 2, 3].sample
  Movie.find_or_create_by!(
    title: Faker::Lorem.words(title_how_many_words).join(' ').capitalize,
    description: Faker::Lorem.paragraph(5),
    genre_id: genre_ids.sample,
    released_at: Faker::Date.between(40.years.ago, Date.today)
  )
end
