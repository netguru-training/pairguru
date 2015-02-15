class GenreDecorator < Draper::Decorator
  delegate :name, :created_at

  def number_of_movies
    object.movies.count
  end
end
