require "faker"

Rails.logger = Logger.new(STDOUT)

Rails.logger.info "Creating users..."

unless User.find_by(email: "user@example.com")
  User.create!(
    email: "user@example.com",
    password: "userexample11",
    confirmed_at: Time.zone.now
  )
end

20.times do
  User.create!(
    email: Faker::Internet.email,
    confirmed_at: Time.zone.now,
    password: "commonpass11"
  )
end

Rails.logger.info "Creating genres..."

%w(Action Comedy Sci-Fi War Crime
   Horror Sport Western Drama
   Musicial Romance Thriller).each do |genre|
  Genre.find_or_create_by!(name: genre)
end

movies = [
  {
    title: "Pulp Fiction",
    release_year: "1994"
  },
  {
    title: "Django",
    release_year: "2012"
  },
  {
    title: "Kill Bill",
    release_year: "2003"
  },
  {
    title: "Kill Bill 2",
    release_year: "2004"
  },
  {
    title: "Inglourious Basterds",
    release_year: "2009"
  },
  {
    title: "Godfather",
    release_year: "1972"
  },
  {
    title: "The Dark Knight",
    release_year: "2008"
  },
  {
    title: "Star Wars V",
    release_year: "1980"
  },
  {
    title: "Inception",
    release_year: "2010"
  },
  {
    title: "Deadpool",
    release_year: "2016"
  }
]

Rails.logger.info "Creating movies..."

genre_ids = Genre.pluck(:id)
100.times do
  movie = movies.sample
  Movie.find_or_create_by!(
    title: movie[:title],
    description: Faker::Lorem.paragraph(5),
    genre_id: genre_ids.sample,
    released_at: Date.new(movie[:release_year].to_i)
  )
end
