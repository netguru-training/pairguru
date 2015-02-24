class GenreDecorator < Draper::Decorator
  delegate_all
  decorates_association :movies

  def number_of_movies
    object.movies.count
  end
end
