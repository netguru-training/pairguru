module Genres
  class Serialize < ActiveModel::Serializer
    attributes :id, :name, :number_of_movies

    def number_of_movies
      object.movies.count
    end
  end
end
