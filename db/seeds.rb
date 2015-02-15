puts 'Creating genres...'

%w(Action Comedy Sci-Fi War Crime
   Horror Sport Western Drama
   Musicial Romance Thriller
).each do |genre|
  Genre.find_or_create_by(name: genre)
end
