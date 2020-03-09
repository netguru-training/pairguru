# frozen_string_literal: true

module Movies
  class Organize
    IMAGE_URL = 'https://pairguru-api.herokuapp.com/'
    Movie = Struct.new(
      :id,
      :title,
      :released_at,
      :genre_id,
      :genre_name,
      :created_at,
      :updated_at,
      :description,
      :avatar,
      :rating
    )

    def self.call(movies_list, imported_movies_data)
      new.call(movies_list, imported_movies_data)
    end

    def call(movies_list, imported_movies_data)
      movies_list.map do |movie|
        merge_movie_with_imported_data(movie, imported_movies_data)
      end
    end

    private

    def merge_movie_with_imported_data(movie, imported_movies_data)
      Movie.new(
        movie&.id,
        movie&.title,
        movie&.released_at,
        movie&.genre_id,
        movie&.genre.name,
        movie&.created_at,
        movie&.updated_at,
        imported_movies_data["#{movie.title}"]['plot'],
        image_path(imported_movies_data["#{movie.title}"]['poster']),
        imported_movies_data["#{movie.title}"]['rating']
      )
    end

    def image_path(image)
      IMAGE_URL + image
    end
  end
end
